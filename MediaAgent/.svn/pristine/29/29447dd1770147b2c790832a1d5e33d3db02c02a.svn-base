package com.MediaAgent.main;

import java.io.File;
import java.util.List;
import java.util.Timer;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.MediaAgent.constants.MAConsts;
import com.MediaAgent.controller.MovieController;
import com.MediaAgent.controller.SubtitleController;
import com.MediaAgent.controller.TvshowController;
import com.MediaAgent.controller.WatchController;
import com.MediaAgent.timer.MovieRefresh;
import com.MediaAgent.timer.SubtitleRefresh;
import com.MediaAgent.timer.TvshowRefresh;
import com.MediaAgent.util.MediaAgentUtil;


public class MediaAgent {

	public static List<File> medias;// = new ArrayList<File>();
	public static List<File> subtitles;// = new ArrayList<File>();
	public static List<File> directories;// = new ArrayList<File>();
	
	private static ExecutorService mainExecutor = Executors.newFixedThreadPool(10);
	private static ScheduledExecutorService scheduleExecutor = Executors.newScheduledThreadPool(4);
	private MediaAgentUtil util = new MediaAgentUtil();
	
	private Logger log = LoggerFactory.getLogger(MediaAgent.class);
	
	public static void main(String[] args) {
		
		Thread watch = new Thread(new WatchController(MAConsts.WATCH_DIR));
		watch.setName("WatchController");
//		watch.start();

		Thread movie = new Thread(new MovieController(MAConsts.MOVIE_DIR));
		movie.setName("MovieController");
//		movie.start();
		
		Thread tvshow = new Thread(new TvshowController(MAConsts.TV_DIR));
		tvshow.setName("TvshowController");
//		tvshow.start();
		
		Thread subtitle = new Thread(new SubtitleController(MAConsts.SUB_DIR));
		subtitle.setName("SubtitleController");
//		subtitle.start();
		
		mainExecutor.execute(watch);
		mainExecutor.execute(movie);
		mainExecutor.execute(tvshow);
		mainExecutor.execute(subtitle);
		
		new MediaAgent().start();
		
		if(MAConsts.REFRESH_CYCLE != 0) {
			scheduleExecutor.scheduleAtFixedRate(new MovieRefresh(MAConsts.MOVIE_DIR), 0, MAConsts.REFRESH_CYCLE, TimeUnit.HOURS);
			scheduleExecutor.scheduleAtFixedRate(new TvshowRefresh(MAConsts.TV_DIR), 0, MAConsts.REFRESH_CYCLE, TimeUnit.HOURS);
			scheduleExecutor.scheduleAtFixedRate(new SubtitleRefresh(MAConsts.SUB_DIR), 0, MAConsts.REFRESH_CYCLE, TimeUnit.HOURS);
		} else {
			scheduleExecutor.shutdownNow();
		}
		
	}
	
	public void start() {
		
		log.info("==============================================================");
		log.info("Media Agent Start... ");
		log.info("WATCH_DIR : " + MAConsts.WATCH_PATH);
		log.info("MOVIE_DIR : " + MAConsts.MOVIE_PATH);
		log.info("TVSHOW_DIR : " + MAConsts.TV_PATH);
		log.info("SUBTITLE_DIR : " + MAConsts.SUB_PATH);
		if(MAConsts.REFRESH_CYCLE != 0) {
			log.info("Refresh Cycle : " + MAConsts.REFRESH_CYCLE + " hours...");
		}
		log.info("==============================================================");
		
	}

}

























