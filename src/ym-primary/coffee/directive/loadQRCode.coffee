angular.module 'ahaLuminateApp'
  .directive 'loadQrcode', [
    'APP_INFO'
    '$rootScope'
    '$timeout'
    (APP_INFO, $rootScope, $timeout) ->
      (scope, element, attrs) ->
        $timeout ->
          if $scope.participantRegistration.companyInformation?.isCompanyCoordinator is 'true'
            img = new Image
            img.src = angular.element('.qrcode-logo').attr('src')
            img.onload = ->
              jQuery(element).kjua
                'render': 'canvas'
                'crisp': true
                'ecLevel': 'H'
                'minVersion': 1
                'fill': '#333333'
                'back': '#ffffff'
                'text': $rootScope.secureDomain + '/site/TR?pg=company&fr_id=' + $scope.frId + '&company_id=' + $scope.participantRegistration.companyInformation.companyId
                'size': 300
                'rounded': 300
                'quiet': 1
                'mode': 'image'
                'mSize': 20
                'mPosX': 50
                'mPosY': 50
                'label': 'KHC'
                'fontname': 'Luckiest Guy'
                'fontcolor': '#c10e21'
                'image': angular.element('.qrcode-logo').get(0)
  ]
