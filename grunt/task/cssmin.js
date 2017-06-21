/* jshint strict:false */

module.exports = {
  options: {
    noAdvanced: true
  }, 
  
  "general": {
    files: [
      {
        src: 'dist/general/css/main.css', 
        dest: 'dist/general/css/main.'+ '<%= timestamp %>' +'.min.css'
      }
    ]
  }, 
  
  "heart-walk": {
    files: [
      {
        src: 'dist/heart-walk/css/main.css', 
        dest: 'dist/heart-walk/css/main.'+ '<%= timestamp %>' +'.min.css'
      }, 
      {
        src: 'dist/heart-walk/css/participant.css', 
        dest: 'dist/heart-walk/css/participant.'+'<%= timestamp %>'+'.min.css'
      }, 
      {
        src: 'dist/heart-walk/css/pageEdit.css', 
        dest: 'dist/heart-walk/css/pageEdit.'+'<%= timestamp %>'+'.min.css'
      }
    ]
  }, 
  
  "jump-hoops": {
    files: [
      {
        src: 'dist/jump-hoops/css/main.css', 
        dest: 'dist/jump-hoops/css/main.'+ '<%= timestamp %>' +'.min.css'
      }, 
      {
        src: 'dist/jump-hoops/css/participant.css', 
        dest: 'dist/jump-hoops/css/participant.'+'<%= timestamp %>'+'.min.css'
      }
    ]
  }, 
  
  "middle-school": {
    files: [
      {
        src: 'dist/middle-school/css/main.css', 
        dest: 'dist/middle-school/css/main.'+ '<%= timestamp %>' +'.min.css'
      }, 
      {
        src: 'dist/middle-school/css/participant.css', 
        dest: 'dist/middle-school/css/participant.'+'<%= timestamp %>'+'.min.css'
      }
    ]
  }, 
  
  "district-heart": {
    files: [
      {
        src: 'dist/district-heart/css/main.css', 
        dest: 'dist/district-heart/css/main.'+ '<%= timestamp %>' +'.min.css'
      }, 
      {
        src: 'dist/district-heart/css/participant.css', 
        dest: 'dist/district-heart/css/participant.'+'<%= timestamp %>'+'.min.css'
      }
    ]
  }
}