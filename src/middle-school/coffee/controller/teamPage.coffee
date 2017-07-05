angular.module 'ahaLuminateControllers'
  .controller 'TeamPageCtrl', [
    '$rootScope'
    '$scope'
    '$location'
    '$filter'
    '$timeout'
    '$uibModal'
    'APP_INFO'
    'TeamraiserTeamService'
    'TeamraiserParticipantService'
    'TeamraiserCompanyService'
    'BoundlessService'
    'TeamraiserTeamPageService'
    ($rootScope, $scope, $location, $filter, $timeout, $uibModal, APP_INFO, TeamraiserTeamService, TeamraiserParticipantService, TeamraiserCompanyService, BoundlessService, TeamraiserTeamPageService) ->
      $scope.teamId = $location.absUrl().split('team_id=')[1].split('&')[0].split('#')[0]
      $scope.teamParticipants = []
      $rootScope.teamName = ''
      $scope.eventDate = ''
      $scope.participantCount = ''
      
      setTeamProgress = (amountRaised, goal) ->
        $scope.teamProgress = 
          amountRaised: if amountRaised then Number(amountRaised) else 0
          goal: if goal then Number(goal) else 0
        $scope.teamProgress.amountRaisedFormatted = $filter('currency')($scope.teamProgress.amountRaised / 100, '$').replace '.00', ''
        $scope.teamProgress.goalFormatted = $filter('currency')($scope.teamProgress.goal / 100, '$').replace '.00', ''
        $scope.teamProgress.percent = 0
        if not $scope.$$phase
          $scope.$apply()
        $timeout ->
          percent = $scope.teamProgress.percent
          if $scope.teamProgress.goal isnt 0
            percent = Math.ceil(($scope.teamProgress.amountRaised / $scope.teamProgress.goal) * 100)
          if percent > 100
            percent = 100
          $scope.teamProgress.percent = percent
          if not $scope.$$phase
            $scope.$apply()
        , 500
      setCoordinatorInfo = ->
        if not $rootScope.$$phase
          $rootScope.$apply()
        if not $scope.$$phase
          $scope.$apply()
      getTeamData = ->
        TeamraiserTeamService.getTeams 'team_id=' + $scope.teamId, 
          error: ->
            setTeamProgress()
          success: (response) ->
            teamInfo = response.getTeamSearchByInfoResponse?.team
            companyId = teamInfo.companyId
            $scope.participantCount = teamInfo.numMembers
            
            BoundlessService.getSchoolRollupTotals companyId + '/' + $scope.teamId
            .then (response) ->
              if response.data.status isnt 'success'
                $scope.totalEmails = 0
              else
                totals = response.data.totals
                totalEmails = totals?.total_online_emails_sent or '0'
                $scope.totalEmails = Number totalEmails
            
            if not teamInfo
              setTeamProgress()
            else
              setTeamProgress teamInfo.amountRaised, teamInfo.goal
            
            TeamraiserCompanyService.getCompanies 'company_id=' + companyId, 
              success: (response) ->
                coordinatorId = response.getCompaniesResponse?.company.coordinatorId
                eventId = response.getCompaniesResponse?.company.eventId
                
                TeamraiserCompanyService.getCoordinatorQuestion coordinatorId, eventId
                  .then (response) ->
                    $scope.eventDate = response.data.coordinator.event_date
                    setCoordinatorInfo()
      getTeamData()
      
      setTeamParticipants = (participants, totalNumber, totalFundraisers) ->
        $scope.teamParticipants.participants = participants or []
        $scope.teamParticipants.totalNumber = totalNumber or 0
        $scope.teamParticipants.totalFundraisers = totalFundraisers or 0
        if not $scope.$$phase
          $scope.$apply()
      getTeamParticipants = ->
        TeamraiserParticipantService.getParticipants 'team_name=' + encodeURIComponent('%') + '&first_name=' + encodeURIComponent('%%') + '&last_name=' + encodeURIComponent('%') + '&list_filter_column=reg.team_id&list_filter_text=' + $scope.teamId + '&list_sort_column=total&list_ascending=false&list_page_size=50', 
            error: (response) ->
              setTeamParticipants()
            success: (response) ->
              $scope.studentsRegisteredTotal = response.getParticipantsResponse.totalNumberResults
              participants = response.getParticipantsResponse?.participant
              if participants
                participants = [participants] if not angular.isArray participants
                teamParticipants = []
                totalFundraisers = 0
                angular.forEach participants, (participant) ->
                  participant.amountRaised = Number participant.amountRaised
                  if participant.name?.first and participant.amountRaised > 1
                    participant.firstName = participant.name.first
                    participant.lastName = participant.name.last
                    participant.name.last = participant.name.last.substring(0, 1) + '.'
                    participant.fullName = participant.name.first + ' ' + participant.name.last
                    participant.amountRaisedFormatted = $filter('currency')(participant.amountRaised / 100, '$').replace '.00', ''
                    if participant.donationUrl
                      participant.donationFormId = participant.donationUrl.split('df_id=')[1].split('&')[0]
                    teamParticipants.push participant
                    totalFundraisers++
                totalNumberParticipants = response.getParticipantsResponse.totalNumberResults
                setTeamParticipants teamParticipants, totalNumberParticipants, totalFundraisers
      getTeamParticipants()
      
      $scope.teamPagePhoto1 =
        defaultUrl: APP_INFO.rootPath + 'dist/middle-school/image/team-default.jpg'
      
      $scope.editTeamPhoto1 = ->
        delete $scope.updateTeamPhoto1Error
        $scope.editTeamPhoto1Modal = $uibModal.open
          scope: $scope
          templateUrl: APP_INFO.rootPath + 'dist/middle-school/html/modal/editTeamPhoto1.html'
      
      $scope.closeTeamPhoto1Modal = ->
        delete $scope.updateTeamPhoto1Error
        $scope.editTeamPhoto1Modal.close()
      
      $scope.cancelEditTeamPhoto1 = ->
        $scope.closeTeamPhoto1Modal()
      
      $scope.deleteTeamPhoto1 = (e) ->
        if e
          e.preventDefault()
        angular.element('.js--delete-team-photo-1-form').submit()
        false
      
      window.trPageEdit =
        uploadPhotoError: (response) ->
          errorResponse = response.errorResponse
          photoNumber = errorResponse.photoNumber
          errorCode = errorResponse.code
          errorMessage = errorResponse.message
          
          if photoNumber is '1'
            $scope.updateTeamPhoto1Error =
              message: errorMessage
          if not $scope.$$phase
            $scope.$apply()
        uploadPhotoSuccess: (response) ->
          delete $scope.updateTeamPhoto1Error
          if not $scope.$$phase
            $scope.$apply()
          successResponse = response.successResponse
          photoNumber = successResponse.photoNumber
          
          TeamraiserTeamPageService.getTeamPhoto
            error: (response) ->
              # TODO
            success: (response) ->
              photoItems = response.getTeamPhotoResponse?.photoItem
              if photoItems
                photoItems = [photoItems] if not angular.isArray photoItems
                angular.forEach photoItems, (photoItem) ->
                  photoUrl = photoItem.customUrl
                  photoCaption = photoItem.caption
                  if not photoCaption or not angular.isString(photoCaption)
                    photoCaption = ''
                  if photoItem.id is '1'
                    $scope.teamPagePhoto1.customUrl = photoUrl
                    $scope.teamPagePhoto1.caption = photoCaption
              if not $scope.$$phase
                $scope.$apply()
              $scope.closeTeamPhoto1Modal()
      
      $scope.teamPageContent =
        mode: 'view'
        serial: new Date().getTime()
        textEditorToolbar: [
          [
            'bold'
            'italics'
            'underline'
          ]
          [
            'ul'
            'ol'
          ]
          [
            'insertImage'
            'insertLink'
          ]
          [
            'undo'
            'redo'
          ]
        ]
        rich_text: angular.element('.js--default-page-content').html()
        ng_rich_text: angular.element('.js--default-page-content').html()
      
      $scope.editTeamPageContent = ->
        richText = $scope.teamPageContent.ng_rich_text
        $richText = jQuery '<div />',
          html: richText
        richText = $richText.html()
        richText = richText.replace(/<strong>/g, '<b>').replace(/<strong /g, '<b ').replace /<\/strong>/g, '</b>'
        .replace(/<em>/g, '<i>').replace(/<em /g, '<i ').replace /<\/em>/g, '</i>'
        $scope.teamPageContent.ng_rich_text = richText
        $scope.teamPageContent.mode = 'edit'
        $timeout ->
          angular.element('[ta-bind][contenteditable]').focus()
        , 100
      
      $scope.resetTeamPageContent = ->
        $scope.teamPageContent.ng_rich_text = $scope.teamPageContent.rich_text
        $scope.teamPageContent.mode = 'view'
      
      $scope.saveTeamPageContent = (isRetry) ->
        richText = $scope.teamPageContent.ng_rich_text
        $richText = jQuery '<div />', 
          html: richText
        richText = $richText.html()
        richText = richText.replace /<\/?[A-Z]+.*?>/g, (m) ->
          m.toLowerCase()
        .replace(/<font>/g, '<span>').replace(/<font /g, '<span ').replace /<\/font>/g, '</span>'
        .replace(/<b>/g, '<strong>').replace(/<b /g, '<strong ').replace /<\/b>/g, '</strong>'
        .replace(/<i>/g, '<em>').replace(/<i /g, '<em ').replace /<\/i>/g, '</em>'
        .replace(/<u>/g, '<span style="text-decoration: underline;">').replace(/<u /g, '<span style="text-decoration: underline;" ').replace /<\/u>/g, '</span>'
        .replace /[\u00A0-\u9999\&]/gm, (i) ->
          '&#' + i.charCodeAt(0) + ';'
        .replace /&#38;/g, '&'
        .replace /<!--[\s\S]*?-->/g, ''
        TeamraiserTeamPageService.updateTeamPageInfo 'rich_text=' + encodeURIComponent(richText),
          error: ->
            # TODO
          success: (response) ->
            if response.teamraiserErrorResponse
              errorCode = response.teamraiserErrorResponse.code
              if errorCode is '2647' and not isRetry
                $scope.teamPageContent.ng_rich_text = response.teamraiserErrorResponse.body
                $scope.savePageContent true
            else
              isSuccess = response.updateTeamPageResponse?.success is 'true'
              if not isSuccess
                # TODO
              else
                $scope.teamPageContent.rich_text = richText
                $scope.teamPageContent.ng_rich_text = richText
                $scope.teamPageContent.mode = 'view'
                if not $scope.$$phase
                  $scope.$apply()
  ]