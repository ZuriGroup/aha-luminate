angular.module 'ahaLuminateControllers'
  .controller 'RegistrationWaiverCtrl', [
    '$scope'
    'SchoolLookupService'
    ($scope, SchoolLookupService) ->
      $scope.submitWaiver = ->
        angular.element('.js--registration-waiver-form').submit()
        false
      
      $scope.submitWaiver()
      setCompanyCity = (companyCity) ->
        $rootScope.companyCity = companyCity
        if not $rootScope.$$phase
          $rootScope.$apply()
          
      setCompanyState = (companyState) ->
        $rootScope.companyState = companyState
        if not $rootScope.$$phase
          $rootScope.$apply()
          
      SchoolLookupService.getSchoolData()
        .then (response) ->
          schoolDataRows = response.data.getSchoolSearchDataResponse.schoolData
          angular.forEach schoolDataRows, (schoolDataRow, schoolDataRowIndex) ->
            if schoolDataRowIndex > 0
              if regCompanyId is schoolDataRow[0]
                setCompanyCity schoolDataRow[1]
                setCompanyState schoolDataRow[2]
                return
  ]
