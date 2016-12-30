gulp = require 'gulp'
$ = do require 'gulp-load-plugins'

dest = './dest/'

gulp.task 'default', ['serve', 'watch']

gulp.task 'serve', ->
  gulp.src 'dest'
    .pipe $.webserver
      livereload: true
      fallback: '404.html'

gulp.task 'jade', ->
  gulp.src './src/**/*.jade'
    .pipe $.jade pretty: true
    .pipe gulp.dest dest

gulp.task 'static', ->
  gulp.src './static/**/*'
    .pipe gulp.dest dest

gulp.task 'symlink', ->
  gulp.src dest+'index.html'
    .pipe $.sym dest+'about/index.html', {relative: true, force: true}
    .pipe $.sym dest+'links/index.html', {relative: true, force: true}
    .pipe $.sym dest+'loves/index.html', {relative: true, force: true}
    .pipe $.sym dest+'think/index.html', {relative: true, force: true}

gulp.task 'bower', ->
  $.bower dest+'components'

gulp.task 'watch', ['watch:jade', 'watch:static']

gulp.task 'watch:static', ->
  $.watch './static/**/*', ->
    gulp.start 'static'

gulp.task 'watch:jade', ->
  $.watch ['./src/**/*.jade', './src/**/*.coffee'], ->
    gulp.start 'jade'

gulp.task 'release', ->
  dest = './release/'
  gulp.start ['jade', 'static', 'symlink', 'bower']
