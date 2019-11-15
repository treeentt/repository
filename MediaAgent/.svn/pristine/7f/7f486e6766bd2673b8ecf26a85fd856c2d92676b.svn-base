package com.MediaAgent.timer;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.TimerTask;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.MediaAgent.constants.MAConsts;
import com.MediaAgent.controller.TvshowController;
import com.MediaAgent.util.KeyManager;
import com.MediaAgent.util.MediaAgentUtil;

public class TvshowRefresh extends TimerTask {
	
	private Logger log = LoggerFactory.getLogger(TvshowRefresh.class);
	private MediaAgentUtil util = new MediaAgentUtil();
	
	private File refreshDir;
	
	public TvshowRefresh(File refreshDir) {
		this.refreshDir = refreshDir;
	}

	@Override
	public void run() {
		log.info("================== TVSHOW REFRESH START ======================");
		start(refreshDir);
		log.info("=================== TVSHOW REFRESH END =======================");
	}
	
	public void start(File refreshDir) {
		
		TvshowController.tvshowfiles.clear();
		getAllFile(MAConsts.TV_DIR);
		chmod(refreshDir.getAbsolutePath(), MAConsts.PERMISSION_777);
		
	}
	
	public void getAllFile(File file) {
		
		try {
			ConcurrentHashMap<String, File> tvshowFile = new ConcurrentHashMap<>();
			
			//파일인 경우 리스트에 넣음
			if(file.isFile()) {
				
				//시리즈 패턴이 있으면
				if(util.hasSiriesPattern(file)) {
//					String key = util.getPureSiriesName(file.getName());
					String key = new KeyManager().getTvKey(file, false);
					String fileKey = util.getRegStr(file.getName(), MAConsts.SEASON_PATTERN) + util.getRegStr(file.getName(), MAConsts.SIRIES_PATTERN);
					
					String ext = FilenameUtils.getExtension(file.getName());
					
					if(util.isMediaFile(file)) {
						ConcurrentHashMap<String, File> files = new ConcurrentHashMap<>();
						files.put(fileKey, file);
						
						//키값이 없으면
						if(!TvshowController.tvshowfiles.containsKey(key)) {
							TvshowController.tvshowfiles.put(key, files);
						} else {
							TvshowController.tvshowfiles.get(key).putAll(files);
						}
						log.debug(TvshowController.tvshowfiles.toString());
						return;
					} else if(util.isSubtitle(file)) {
						
						ConcurrentHashMap<String, File> files = new ConcurrentHashMap<>();
						
						List<String> subtitleExtList = Arrays.asList(MAConsts.subtitleExts);
						for(String subExt : subtitleExtList) {
							if(ext.equalsIgnoreCase(subExt)) {
								String subKey = fileKey + "_" + subExt;
								files.put(subKey, file);
								if(!TvshowController.tvshowfiles.containsKey(key)) {
									TvshowController.tvshowfiles.put(key, files);
								} else {
									TvshowController.tvshowfiles.get(key).putAll(files);
								}
								log.debug(TvshowController.tvshowfiles.toString());
							}
						}
					}
				}
				//날짜 패턴만 있으면
				else if(util.hasDatePattern(file) && !util.hasSiriesPattern(file)) {
					
				}
				return;
				
			//디렉토리인 경우 다시 검사
			} else if(file.isDirectory()) {
//				String key = file.getName();
				String key = new KeyManager().getTvKey(file, true);
				
				File[] fileList = file.listFiles();
				//하위 파일이 있을 경우 Recursive
				if(fileList.length > 0) {
					if(!file.equals(MAConsts.TV_DIR)) {
						tvshowFile.put(MAConsts.DIRECTORY, file);
						if(!TvshowController.tvshowfiles.containsKey(key)) {
							TvshowController.tvshowfiles.put(key, tvshowFile);
						} else {
							TvshowController.tvshowfiles.get(key).putAll(tvshowFile);
						}
					}
					for(File tempFile : fileList) {
						getAllFile(tempFile);
					}
				}
			}
		} catch (Exception e) {
			log.info(e.toString());
			e.printStackTrace();
		}
	}//getAllFile
	
	public boolean chmod(String path, String auth) {
		String command = "chmod -R " + auth + " \"" + path + "\"";
		String result = util.runShell(command);
		
		if(result.equals(MAConsts.SUCCESS)) {
			return true;
		} 
		return false;
	}
	
}




















