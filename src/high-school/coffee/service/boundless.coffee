angular.module 'ahaLuminateApp'
  .factory 'BoundlessService', [
    '$rootScope'
    '$http'
    '$sce'
    ($rootScope, $http, $sce) ->
      getBadges: (requestData) ->
        if $rootScope.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://aha-hs-staging.boundlessnetwork.com/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://aha-highschool.boundlessnetwork.com/api/badges/student/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
      
      getRollupTotals: ->
        if $rootScope.tablePrefix is 'heartdev'
          # TODO
        else
          # url = 'https://aha-highschool.boundlessnetwork.com/api/schools/totals'
          url = 'https://aha-hs-staging.boundlessnetwork.com/api/schools/totals'
        $http.jsonp($sce.trustAsResourceUrl(url), jsonpCallbackParam: 'callback')
          .then (response) ->
            response
          , (response) ->
            response
      
      getSchoolRollupTotals: (requestData) ->
        if $rootScope.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://aha-hs-staging.boundlessnetwork.com/api/schools/totals/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://aha-highschool.boundlessnetwork.com/api/schools/totals/' + requestData) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'GET'
          url: url
          headers:
            'Content-Type': 'application/json'
      
      logEmailSent: ->
        if $rootScope.tablePrefix is 'heartdev'
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://aha-hs-staging.boundlessnetwork.com/api/webhooks/student/personal-page-updated/' + $rootScope.frId + '/' + $rootScope.consId) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        else
          url = 'AjaxProxy?cnv_url=' + encodeURIComponent('https://aha-highschool.boundlessnetwork.com/api/webhooks/student/personal-page-updated/' + $rootScope.frId + '/' + $rootScope.consId) + '&auth=' + luminateExtend.global.ajaxProxyAuth
        $http
          method: 'POST'
          url: url
          headers:
            'Content-Type': 'application/json'
  ]