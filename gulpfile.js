const { src, dest, series } = require('gulp');
const del = require('del');

function clean() {
  return del(['dist/**']);
}

function copy() {
  return src([
    '**/*',
    '!node_modules/**',
    '!src/**',
    '!tests/**',
    '!dist/**',
    '!.git/**',
    '!.github/**',
    '!gulpfile.js',
    '!rollup.config.js',
    '!package*.json',
    '!composer.*',
    '!phpunit.xml.dist'
  ], { dot: true })
  .pipe(dest('dist/plugin-starter'));
}

exports['build-dist'] = series(clean, copy);