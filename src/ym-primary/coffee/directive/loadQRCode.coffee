angular.module 'ahaLuminateApp'
  .directive 'loadQrcode', ->
    (scope, element, attrs) ->
      if $scope.participantRegistration.companyInformation?.isCompanyCoordinator is 'true'
        jQuery(element).qrcode
          mode: 3
          image: APP_INFO.rootPath + 'dist/ym-primary/image/fy21/khc-logo-2021.png'
          size: 150
          fill: '#212121'
          text: $rootScope.secureDomain + '/site/TR?pg=company&fr_id='+$scope.frId + '&company_id=' + $scope.participantRegistration.companyInformation.companyId
