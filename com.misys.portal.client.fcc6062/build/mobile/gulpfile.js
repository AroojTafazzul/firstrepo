var gulp = require('gulp');
var gutil = require('gulp-util');
var uglify = require('gulp-uglify');
var merge = require('merge-stream');
var paths = require('./gulp.config.json');
var plug = require('gulp-load-plugins')();
var path = require('path');
var eslint = require('gulp-eslint');
var minifyCss = require('gulp-minify-css');
var concatCss = require('gulp-concat-css');
var rename = require("gulp-rename");
var log = plug.util.log;
var colors = plug.util.colors;
var env = plug.util.env;
var log = plug.util.log;
var port = process.env.PORT || 7203;

//check lint results to console 
gulp.task('lint', function () {
	log('Checking for Lint errors and warnings');
    // ESLint ignores files with "node_modules" paths.
    // So, it's best to have gulp ignore the directory as well.
    // Also, Be sure to return the stream from the task;
    // Otherwise, the task may end before the stream has finished.
    return gulp.src(['../../doc_root/content/mobile/js/**/*.js',''])
        // eslint() attaches the lint output to the "eslint" property
        // of the file object so it can be used by other modules.
        .pipe(eslint())
        // eslint.format() outputs the lint results to the console.
        // Alternatively use eslint.formatEach() (see Docs).
        .pipe(eslint.format())
        // To have the process exit with an error code (1) on
        // lint error, return the stream and pipe to failAfterError last.
        .pipe(eslint.failAfterError());
});

// create a default task and just log a message
gulp.task('default', function() {
  return gutil.log('Gulp is running!')
});

gulp.task('copyHtml', function() {
  // copy any html files in source/ to public/
  gulp.src('../../doc_root/content/mobile/template/**/*.html').pipe(gulp.dest('public'));
});

gulp.task('compress', function() {
  return gulp.src('../../doc_root/content/mobile/js/**/*.js')
    .pipe(uglify())
    .pipe(gulp.dest('dist'));
});

/**
 * Minify and bundle the app's CSS
 */
gulp.task('bundle-css',['bundle-core-appl-css','bundle-third-party-lib-css','bundle-third-party-lib-minified-css']);

gulp.task('bundle-third-party-lib-css', function() {
	  return gulp.src(paths.thirdPartyStylesheets)
	    .pipe(concatCss("bundle-lib.css"))
	    .pipe(gulp.dest(paths.build));
	});

gulp.task('bundle-third-party-lib-minified-css', function() {
	  return gulp.src(paths.thirdPartyMinifiedStylesheets)
	    .pipe(concatCss("bundle-lib.min.css"))
	    .pipe(minifyCss({compatibility: 'ie8'}))
	    .pipe(gulp.dest(paths.build));
	});


gulp.task('bundle-core-appl-css', ['bundle-core-css','bundle-client-css']);

gulp.task('bundle-core-css', function() {
	log('Bundling, minifying, and copying the app\'s CSS');
    return gulp.src(paths.coreApplCSS.core)
        .pipe(minifyCss({compatibility: 'ie8'}))
        .pipe(rename('app.min.css'))
        .pipe(gulp.dest(paths.buildCoreCSS));
       
});

gulp.task('bundle-client-css', function() {
	log('Bundling, minifying, and copying the app\'s CSS');
    return gulp.src(paths.coreApplCSS.client)
        .pipe(minifyCss({compatibility: 'ie8'}))
        .pipe(rename('client.min.css'))
        .pipe(gulp.dest(paths.buildCoreCSS));
       
});


/**
 * Minify and bundle the app's JavaScript
 */
gulp.task('bundle-js', ['lint','bundle-core-js','bundle-third-party-lib-js','bundle-third-party-lib-minified-js']);

gulp.task('bundle-core-js', function() {
    log('Bundling, minifying, and copying the app\'s JavaScript');

    var source = [].concat(paths.coreApplJS, paths.build + 'templates.js');
    return gulp
        .src(source)
        .pipe(plug.concat('bundle-core.min.js'))
        .pipe(plug.ngAnnotate({
        add: true,
        single_quotes: true
    })).pipe(plug.uglify({
        mangle: true
    }))
        .pipe(gulp.dest(paths.build));
});


gulp.task('bundle-third-party-lib-js', function() {
    log('Bundling and copying the app\'s third party lib JavaScripts');

    return gulp.src(paths.thirdPartyScripts)
        .pipe(plug.concat('bundle-lib.js'))
        .pipe(gulp.dest(paths.build));
});

gulp.task('bundle-third-party-lib-minified-js', function() {
    log('Bundling, minifying, and copying the app\'s third party lib JavaScripts');

    return gulp.src(paths.thirdPartyMinifedScripts)
        .pipe(plug.concat('bundle-lib.min.js'))
        .pipe(gulp.dest(paths.build));
});

/**
 * Build Process
 * Check Lint, Bundling, minifying, and copying the MobileWeb's JS and CSS
 */
gulp.task('build', ['bundle-js','bundle-css']);

/**
 * Run specs once and exit
 * To start servers and run midway specs as well:
 *    gulp test --startServers
 * @return {Stream}
 */
gulp.task('test', function(done) {
    startTests(true /*singleRun*/ , done);
});

