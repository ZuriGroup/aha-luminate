/* jshint strict:false */

module.exports = {
  options: {
    jshintrc: 'grunt/.jshintrc'
  }, 
  
  "grunt-config": {
    files: [
      {
        src: [
          'Gruntfile.js', 
          'grunt/task/*.js', 
          'grunt/.jshintrc'
        ]
      }
    ]
  }
}