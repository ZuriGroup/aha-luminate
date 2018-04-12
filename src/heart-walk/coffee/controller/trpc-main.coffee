angular.module 'trPcControllers'
  .controller 'NgPcMainCtrl', [
    '$rootScope'
    '$scope'
    '$location'
    '$timeout'
    'LocaleService'
    'FacebookFundraiserService'
    ($rootScope, $scope, $location, $timeout, LocaleService, FacebookFundraiserService) ->
      $rootScope.$location = $location
      
      $rootScope.baseUrl = $location.absUrl().split('#')[0]
      
      LocaleService.setLocale $rootScope.locale
      
      $rootScope.changeLocale = ->
        LocaleService.setLocale()
      
      $scope.$on '$viewContentLoaded', ->
        addThisChecks = 0
        checkAddThis = ->
          addThisChecks++
          if angular.element('.addthis_toolbox').length > 0
            addthis.toolbox '.addthis_toolbox'
          else if addThisChecks < 13
            $timeout checkAddThis, 250
        checkAddThis()
      
      if $rootScope.facebookFundraisersEnabled
        $rootScope.loginToFacebook = ->
          $rootScope.facebookFundraiserLoginStatus = 'pending'
          FB.login (response) ->
            authResponse = response.authResponse
            if not authResponse
              $rootScope.facebookFundraiserLoginStatus = 'login_error'
            else
              facebookUserId = response.authResponse.userID
              accessToken = response.authResponse.accessToken
              if not facebookUserId or not accessToken
                $rootScope.facebookFundraiserLoginStatus = 'login_error'
              else
                FB.api '/me/permissions', (response) ->
                  manageFundraisersPermisson = null
                  angular.forEach response.data, (permissionObject) ->
                    if permissionObject.permission is 'manage_fundraisers'
                      manageFundraisersPermisson = permissionObject
                  if not manageFundraisersPermisson
                    $rootScope.facebookFundraiserLoginStatus = 'permission_error'
                  else if manageFundraisersPermisson.status is 'declined'
                    $rootScope.facebookFundraiserLoginStatus = 'declined_manage_fundraisers'
                  else
                    $rootScope.facebookFundraiserLoginStatus = 'complete'
                    $rootScope.facebookFundraiserUserId = facebookUserId
                    $rootScope.facebookFundraiserAccessToken = accessToken
                    $rootScope.facebookFundraiserCreateStatus = 'pending'
                    fundraiserName = 'Get pumped up for Heart Walk'
                    FacebookFundraiserService.createFundraiser fundraiserName
                      .then (response) ->
                        facebookFundraiserId = response.data.fundraiser?.id
                        if not facebookFundraiserId
                          $rootScope.facebookFundraiserCreateStatus = 'create_fundraiser_error'
                        else
                          $rootScope.facebookFundraiserCreateStatus = 'complete'
                          $rootScope.facebookFundraiserId = facebookFundraiserId
                          $rootScope.facebookFundraiserUrl =
                            url: 'https://www.facebook.com/donate/' + $rootScope.facebookFundraiserId + '/'
                          FacebookFundraiserService.syncDonations()
                          if $rootScope.coachingMark is 'welcome' or $rootScope.coachingMark is 'facebookFundraiser'
                            $rootScope.coachingMarkModal.close()
                            delete $rootScope.coachingMarkModal
                            angular.element('.modal').click()
                            CoachingMarkService.dismissCoachingMark $rootScope.coachingMark
                          $rootScope.facebookFundraiserConfirmedStatus = 'confirmed'
                          $timeout ->
                            if jQuery('.js--facebook-fundraiser-completed-section').length > 0
                              jQuery('html, body').animate
                                scrollTop: jQuery('.js--facebook-fundraiser-completed-section').offset().top - 150
                              , 250
          , scope: 'manage_fundraisers'
  ]