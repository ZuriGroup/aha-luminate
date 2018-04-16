/* jshint strict:false */

module.exports = {
  options: {
    join: true
  },

  "general": {
    files: {
      'dist/general/js/main.js': [
        'src/general/coffee/init.coffee',
        'src/global/coffee/config/*.*',
        'src/general/coffee/config/*.*',
        'src/global/coffee/service/*.*',
        '!src/global/coffee/service/trpc-*.*',
        'src/general/coffee/service/*.*',
        'src/global/coffee/directive/*.*',
        'src/general/coffee/directive/*.*',
        'src/general/coffee/**/*.*'
      ]
    }
  },

  "heart-walk": {
    files: {
      'dist/heart-walk/js/main.js': [
        'src/heart-walk/coffee/init.coffee',
        'src/global/coffee/config/*.*',
        'src/heart-walk/coffee/config/*.*',
        '!src/heart-walk/coffee/config/trpc-*.*',
        '!src/heart-walk/coffee/config/trPageEdit-*.*',
        'src/global/coffee/service/*.*',
        '!src/global/coffee/service/trpc-*.*',
        'src/heart-walk/coffee/service/*.*',
        '!src/heart-walk/coffee/service/trpc-*.*',
        '!src/heart-walk/coffee/service/trPageEdit-*.*',
        'src/global/coffee/directive/*.*',
        'src/heart-walk/coffee/directive/*.*',
        '!src/heart-walk/coffee/directive/trpc-*.*',
        '!src/heart-walk/coffee/directive/trPageEdit-*.*',
        'src/heart-walk/coffee/**/*.*',
        '!src/heart-walk/coffee/**/trpc-*.*',
        '!src/heart-walk/coffee/**/trPageEdit-*.*'
      ],
      'dist/heart-walk/js/participant.js': [
        'src/heart-walk/coffee/trpc-init.coffee',
        'src/heart-walk/coffee/config/trpc-*.*',
        'src/global/coffee/service/trpc-*.*',
        'src/heart-walk/coffee/**/trpc-*.*'
      ],
      'dist/heart-walk/js/pageEdit.js': [
        'src/heart-walk/coffee/trPageEdit-init.coffee',
        'src/heart-walk/coffee/config/trPageEdit-*.*',
        'src/global/coffee/service/trPageEdit-*.*',
        'src/heart-walk/coffee/**/trPageEdit-*.*'
      ]
    }
  },

  "jump-hoops": {
    files: {
      'dist/jump-hoops/js/main.js': [
        'src/jump-hoops/coffee/init.coffee',
        'src/jump-hoops/coffee/config/*.*',
        '!src/jump-hoops/coffee/config/trpc-*.*',
        'src/global/coffee/service/*.*',
        '!src/global/coffee/service/trpc-*.*',
        'src/youth-markets/coffee/service/*.*',
        'src/youth-markets/coffee/controller/*.*',
        '!src/youth-markets/coffee/service/trpc-*.*',
        'src/jump-hoops/coffee/service/*.*',
        '!src/jump-hoops/coffee/service/trpc-*.*',
        'src/global/coffee/directive/*.*',
        'src/jump-hoops/coffee/directive/*.*',
        '!src/jump-hoops/coffee/directive/trpc-*.*',
        'src/jump-hoops/coffee/**/*.*',
        '!src/jump-hoops/coffee/**/trpc-*.*'
      ],
      'dist/jump-hoops/js/participant.js': [
        'src/jump-hoops/coffee/trpc-init.coffee',
        'src/jump-hoops/coffee/config/trpc-*.*',
        'src/global/coffee/service/trpc-*.*',
        'src/youth-markets/coffee/service/trpc-*.*',
        'src/jump-hoops/coffee/**/trpc-*.*'
      ]
    }
  },

  "middle-school": {
    files: {
      'dist/middle-school/js/main.js': [
        'src/middle-school/coffee/init.coffee',
        'src/middle-school/coffee/config/*.*',
        '!src/middle-school/coffee/config/trpc-*.*',
        'src/global/coffee/service/*.*',
        '!src/global/coffee/service/trpc-*.*',
        'src/youth-markets/coffee/service/*.*',
        'src/youth-markets/coffee/controller/*.*',
        '!src/youth-markets/coffee/service/trpc-*.*',
        'src/middle-school/coffee/service/*.*',
        '!src/middle-school/coffee/service/trpc-*.*',
        'src/global/coffee/directive/*.*',
        'src/middle-school/coffee/directive/*.*',
        '!src/middle-school/coffee/directive/trpc-*.*',
        'src/middle-school/coffee/**/*.*',
        '!src/middle-school/coffee/**/trpc-*.*'
      ],
      'dist/middle-school/js/participant.js': [
        'src/middle-school/coffee/trpc-init.coffee',
        'src/middle-school/coffee/config/trpc-*.*',
        'src/global/coffee/service/trpc-*.*',
        'src/youth-markets/coffee/service/trpc-*.*',
        'src/middle-school/coffee/**/trpc-*.*'
      ]
    }
  },

  "high-school": {
    files: {
      'dist/high-school/js/main.js': [
        'src/high-school/coffee/init.coffee',
        'src/high-school/coffee/config/*.*',
        '!src/high-school/coffee/config/trpc-*.*',
        'src/global/coffee/service/*.*',
        '!src/global/coffee/service/trpc-*.*',
        'src/youth-markets/coffee/service/*.*',
        'src/youth-markets/coffee/controller/*.*',
        '!src/youth-markets/coffee/service/trpc-*.*',
        'src/high-school/coffee/service/*.*',
        '!src/high-school/coffee/service/trpc-*.*',
        'src/global/coffee/directive/*.*',
        'src/high-school/coffee/directive/*.*',
        '!src/high-school/coffee/directive/trpc-*.*',
        'src/high-school/coffee/**/*.*',
        '!src/high-school/coffee/**/trpc-*.*'
      ],
      'dist/high-school/js/participant.js': [
        'src/high-school/coffee/trpc-init.coffee',
        'src/high-school/coffee/config/trpc-*.*',
        'src/global/coffee/service/trpc-*.*',
        'src/youth-markets/coffee/service/trpc-*.*',
        'src/high-school/coffee/**/trpc-*.*'
      ]
    }
  },

  "district-heart": {
    files: {
      'dist/district-heart/js/main.js': [
        'src/district-heart/coffee/init.coffee',
        'src/district-heart/coffee/config/*.*',
        '!src/district-heart/coffee/config/trpc-*.*',
        'src/global/coffee/service/*.*',
        '!src/global/coffee/service/trpc-*.*',
        'src/youth-markets/coffee/service/*.*',
        'src/youth-markets/coffee/controller/*.*',
        '!src/youth-markets/coffee/service/trpc-*.*',
        'src/district-heart/coffee/service/*.*',
        '!src/district-heart/coffee/service/trpc-*.*',
        'src/global/coffee/directive/*.*',
        'src/district-heart/coffee/directive/*.*',
        '!src/district-heart/coffee/directive/trpc-*.*',
        'src/district-heart/coffee/**/*.*',
        '!src/district-heart/coffee/**/trpc-*.*'
      ],
      'dist/district-heart/js/participant.js': [
        'src/district-heart/coffee/trpc-init.coffee',
        'src/district-heart/coffee/config/trpc-*.*',
        'src/global/coffee/service/trpc-*.*',
        'src/youth-markets/coffee/service/trpc-*.*',
        'src/district-heart/coffee/**/trpc-*.*'
      ]
    }
  },
  "heartchase": {
    files: {
      'dist/heartchase/js/main.js': [
        'src/jump-hoops/coffee/init.coffee',
        'src/jump-hoops/coffee/config/*.*',
        'src/global/coffee/service/*.*',
        'src/youth-markets/coffee/service/*.*',
        'src/youth-markets/coffee/controller/*.*',
        'src/jump-hoops/coffee/service/*.*',
        'src/global/coffee/directive/*.*',
        'src/jump-hoops/coffee/directive/*.*',
        'src/jump-hoops/coffee/**/*.*',
      ]
    }
  }
}
