/* jshint strict:false */

module.exports = {
  options: {
    collapseBooleanAttributes: true, 
    collapseWhitespace: true, 
    minifyCSS: true, 
    minifyJS: true, 
    removeComments: true, 
    removeEmptyAttributes: true, 
    removeScriptTypeAttributes: true, 
    removeStyleLinkTypeAttributes: true
  }, 
  
  "general": {
    files: [
      {
        expand: true, 
        cwd: 'dist/general/html/', 
        src: [
          '**/*.*'
        ], 
        dest: "dist/general/html/"
      }
    ]
  }, 
  
  "heart-walk": {
    files: [
      {
        expand: true, 
        cwd: 'dist/heart-walk/html/', 
        src: [
          '**/*.*'
        ], 
        dest: "dist/heart-walk/html/"
      }
    ]
  }, 
  
  "youth-markets": {
    files: [
      {
        expand: true, 
        cwd: 'dist/youth-markets/html/', 
        src: [
          '**/*.*'
        ], 
        dest: "dist/youth-markets/html/"
      }
    ]
  }, 
  
  "jump-hoops": {
    files: [
      {
        expand: true, 
        cwd: 'dist/jump-hoops/html/', 
        src: [
          '**/*.*'
        ], 
        dest: "dist/jump-hoops/html/"
      }
    ]
  }, 
  
  "middle-school": {
    files: [
      {
        expand: true, 
        cwd: 'dist/middle-school/html/', 
        src: [
          '**/*.*'
        ], 
        dest: "dist/middle-school/html/"
      }
    ]
  }, 
  
  "high-school": {
    files: [
      {
        expand: true, 
        cwd: 'dist/high-school/html/', 
        src: [
          '**/*.*'
        ], 
        dest: "dist/high-school/html/"
      }
    ]
  }, 
  
  "district-heart": {
    files: [
      {
        expand: true, 
        cwd: 'dist/district-heart/html/', 
        src: [
          '**/*.*'
        ], 
        dest: "dist/district-heart/html/"
      }
    ]
  },

  "nchw": {
    files: [
      {
        expand: true,
        cwd: 'dist/nchw/html/',
        src: [
          '**/*.*'
        ],
        dest: "dist/nchw/html/"
      }
    ]
  },

  "cyclenation": {
    files: [
      {
        expand: true,
        cwd: 'dist/cyclenation/html/',
        src: [
          '**/*.*'
        ],
        dest: "dist/cyclenation/html/"
      }
    ]
  }
}