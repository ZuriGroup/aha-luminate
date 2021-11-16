angular.module 'ahaLuminateControllers'
  .controller 'MainCtrl', [
    '$rootScope'
    '$scope'
    '$httpParamSerializer'
    'AuthService'
    'TeamraiserParticipantService'
    'TeamraiserRegistrationService'
    'CatalogService'
    '$timeout'
    ($rootScope, $scope, $httpParamSerializer, AuthService, TeamraiserParticipantService, TeamraiserRegistrationService, CatalogService, $timeout) ->
      $dataRoot = angular.element '[data-aha-luminate-root]'
      consId = $dataRoot.data('cons-id') if $dataRoot.data('cons-id') isnt ''
      $scope.regEventId = ''
      $scope.protocol = window.location.protocol

      $scope.headerLoginInfo = 
        user_name: ''
        password: ''
      
      $scope.submitHeaderLogin = ->
        AuthService.login $httpParamSerializer($scope.headerLoginInfo), 
          error: ->
            angular.element('.js--default-header-login-form').submit()
          success: ->
            if not $scope.headerLoginInfo.ng_nexturl or $scope.headerLoginInfo.ng_nexturl is ''
#              window.location = window.location.href
              window.location = $rootScope.secureDomain + 'site/SPageServer?pagename=ym_coordinator_reward_center'
            else
              window.location = $scope.headerLoginInfo.ng_nexturl
      
      if $scope.consId
        CatalogService.getRegistration
          success: (response) ->
            participantRegistration = response.getRegistrationResponse?.registration
            if participantRegistration
              $scope.participantRegistration = participantRegistration

      setRegEventId = (numberEvents = 0, regEventId = '') ->
        $scope.numberEvents = numberEvents
        $scope.regEventId = regEventId
        if not $scope.$$phase
          $scope.$apply()
      if not consId or not luminateExtend.global.isParticipant
        setRegEventId()
      else
        CatalogService.getRegisteredTeamraisers 'cons_id=' + consId + '&event_type=' + encodeURIComponent('YM Kids Heart Challenge 2022'),
          error: ->
            setRegEventId()
          success: (response) ->
            teamraisers = response.getRegisteredTeamraisersResponse?.teamraiser
            if not teamraisers
              setRegEventId()
            else
              teamraisers = [teamraisers] if not angular.isArray teamraisers
              numberEvents = teamraisers.length
              regEventId = ''
              if numberEvents is 1
                regEventId = teamraisers[0].id
              setRegEventId numberEvents, regEventId
                
  ]
