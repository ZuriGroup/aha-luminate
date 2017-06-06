angular.module 'ahaLuminateControllers'
  .controller 'SchoolSearchCtrl', [
    '$rootScope'
    '$scope'
    '$filter'
    'CsvService'
    'UtilsService'
    'SchoolLookupService'
    ($rootScope, $scope, $filter, CsvService, UtilsService, SchoolLookupService) ->
      $scope.states = []
      $scope.schools = []
      $scope.filtered = []
      $scope.schoolList =
        sortProp: 'SCHOOL_STATE'
        sortDesc: true
        totalItems: 0
        currentPage: 1
        numPerPage: 5
        showHelp: false
        typeaheadNoResults: false
        stateFilter: ''
      
      $scope.typeaheadFilter = ($item, $model, $label, $event) ->
        $scope.schoolList.stateFilter = '0'
        $scope.filterSchools()
      
      $scope.filterSchools = ->
        schools = $scope.schools
        filtered = false
        if schools.length and $scope.schoolList.nameFilter
          filtered = true
          schools = $filter('filter') schools, SCHOOL_NAME: $scope.schoolList.nameFilter, true
        if schools.length and $scope.schoolList.stateFilter isnt ''
          filtered = true
          schools = $filter('filter') schools, SCHOOL_STATE: $scope.schoolList.stateFilter
        if not filtered
          schools = []
        $scope.schoolList.totalItems = schools.length
        $scope.filtered = schools
        $scope.orderSchools $scope.schoolList.sortProp, true
      
      $scope.orderSchools = (sortProp, keepSortOrder) ->
        schools = $scope.filtered
        if schools.length
          if keepSortOrder
            # OK
          else
            $scope.schoolList.sortDesc = !$scope.schoolList.sortDesc
          if $scope.schoolList.sortProp isnt sortProp
            $scope.schoolList.sortProp = sortProp
            $scope.schoolList.sortDesc = true
          schools = $filter('orderBy') schools, sortProp, $scope.schoolList.sortDesc
          $scope.filtered = schools
          $scope.schoolList.currentPage = 1
      
      $scope.paginate = (value) ->
        begin = ($scope.schoolList.currentPage - 1) * $scope.schoolList.numPerPage
        end = begin + $scope.schoolList.numPerPage
        index = $scope.filtered.indexOf value
        begin <= index and index < end
      
      SchoolLookupService.getSchools
        failure: (response) ->
          return
        success: (csv) ->
          schools = CsvService.toJson csv
          $scope.schools = schools
          return
  ]