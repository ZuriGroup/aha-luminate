angular.module 'trPcControllers'
  .controller 'NgPcDashboardViewCtrl', [
    '$rootScope'
    '$scope'
    '$filter'
    '$uibModal'
    'APP_INFO'
    'ZuriService'
    'ParticipantBadgesService'
    'NgPcTeamraiserRegistrationService'
    'NgPcTeamraiserProgressService'
    'NgPcTeamraiserTeamService'
    'NgPcTeamraiserCompanyService'
    'NgPcContactService'
    'NgPcTeamraiserShortcutURLService'
    '$location'
    ($rootScope, $scope, $filter, $uibModal, APP_INFO, ZuriService, ParticipantBadgesService, NgPcTeamraiserRegistrationService, NgPcTeamraiserProgressService, NgPcTeamraiserTeamService, NgPcTeamraiserCompanyService, NgPcContactService, NgPcTeamraiserShortcutURLService, $location) ->
      $scope.dashboardPromises = []
      
      if $scope.participantRegistration.companyInformation?.isCompanyCoordinator isnt 'true'
        $scope.dashboardProgressType = 'personal'
      else
        $scope.dashboardProgressType = 'company'
      $scope.toggleProgressType = (progressType) ->
        $scope.dashboardProgressType = progressType
      
      fundraisingProgressPromise = NgPcTeamraiserProgressService.getProgress()
        .then (response) ->
          participantProgress = response.data.getParticipantProgressResponse?.personalProgress
          if participantProgress
            participantProgress.raised = Number participantProgress.raised
            participantProgress.raisedFormatted = if participantProgress.raised then $filter('currency')(participantProgress.raised / 100, '$', 0) else '$0'
            participantProgress.goal = Number participantProgress.goal
            participantProgress.goalFormatted = if participantProgress.goal then $filter('currency')(participantProgress.goal / 100, '$', 0) else '$0'
            participantProgress.percent = 0
            if participantProgress.goal isnt 0
              participantProgress.percent = Math.ceil((participantProgress.raised / participantProgress.goal) * 100)
            if participantProgress.percent > 100
              participantProgress.percent = 100
            $scope.participantProgress = participantProgress
          if $scope.participantRegistration.teamId and $scope.participantRegistration.teamId isnt '-1'
            teamProgress = response.data.getParticipantProgressResponse?.teamProgress
            if teamProgress
              teamProgress.raised = Number teamProgress.raised
              teamProgress.raisedFormatted = if teamProgress.raised then $filter('currency')(teamProgress.raised / 100, '$', 0) else '$0'
              teamProgress.goal = Number teamProgress.goal
              teamProgress.goalFormatted = if teamProgress.goal then $filter('currency')(teamProgress.goal / 100, '$', 0) else '$0'
              teamProgress.percent = 0
              if teamProgress.goal isnt 0
                teamProgress.percent = Math.ceil((teamProgress.raised / teamProgress.goal) * 100)
              if teamProgress.percent > 100
                teamProgress.percent = 100
              $scope.teamProgress = teamProgress
          if $scope.participantRegistration.companyInformation and $scope.participantRegistration.companyInformation.companyId and $scope.participantRegistration.companyInformation.companyId isnt -1
            companyProgress = response.data.getParticipantProgressResponse?.companyProgress
            if companyProgress
              companyProgress.raised = Number companyProgress.raised
              companyProgress.raisedFormatted = if companyProgress.raised then $filter('currency')(companyProgress.raised / 100, '$', 0) else '$0'
              companyProgress.goal = Number companyProgress.goal
              companyProgress.goalFormatted = if companyProgress.goal then $filter('currency')(companyProgress.goal / 100, '$', 0) else '$0'
              companyProgress.percent = 0
              if companyProgress.goal isnt 0
                companyProgress.percent = Math.ceil((companyProgress.raised / companyProgress.goal) * 100)
              if companyProgress.percent > 100
                companyProgress.percent = 100
              $scope.companyProgress = companyProgress
          response
      $scope.dashboardPromises.push fundraisingProgressPromise
      
      $scope.personalGoalInfo = {}
      
      $scope.editPersonalGoal = ->
        personalGoal = $scope.participantProgress.goalFormatted.replace('$', '')
        if personalGoal is '' or personalGoal is '0'
          $scope.personalGoalInfo.goal = ''
        else
          $scope.personalGoalInfo.goal = personalGoal
        $scope.editPersonalGoalModal = $uibModal.open
          scope: $scope
          templateUrl: APP_INFO.rootPath + 'dist/jump-hoops/html/participant-center/modal/editParticipantGoal.html'
      
      $scope.cancelEditPersonalGoal = ->
        $scope.editPersonalGoalModal.close()
      
      $scope.updatePersonalGoal = ->
        # TODO
      
      $scope.teamGoalInfo = {}
      
      $scope.editTeamGoal = ->
        teamGoal = $scope.teamProgress.goalFormatted.replace('$', '')
        if teamGoal is '' or teamGoal is '0'
          $scope.teamGoalInfo.goal = ''
        else
          $scope.teamGoalInfo.goal = teamGoal
        $scope.editTeamGoalModal = $uibModal.open
          scope: $scope
          templateUrl: APP_INFO.rootPath + 'dist/jump-hoops/html/participant-center/modal/editTeamGoal.html'
      
      $scope.cancelEditTeamGoal = ->
        $scope.editTeamGoalModal.close()
      
      $scope.updateTeamGoal = ->
        # TODO
      
      participantBadgesPromise = ParticipantBadgesService.getBadges()
        .then (response) ->
          prizes = response.data.prizes
          if prizes
            $scope.participantBadges = prizes
      $scope.dashboardPromises.push participantBadgesPromise
      
      $scope.donorContactCounts = {}
      donorContactFilters = [
        'email_rpt_show_nondonors_followup'
        'email_rpt_show_unthanked_donors'
        'email_rpt_show_donors'
      ]
      angular.forEach donorContactFilters, (filter) ->
        donorContactCountPromise = NgPcContactService.getTeamraiserAddressBookContacts 'tr_ab_filter=' + filter + '&skip_groups=true&list_page_size=1'
          .then (response) ->
            totalNumberResults = response.data.getTeamraiserAddressBookContactsResponse?.totalNumberResults
            $scope.donorContactCounts[filter] = if totalNumberResults then Number(totalNumberResults) else 0
            response
        $scope.dashboardPromises.push donorContactCountPromise
      
      $scope.personalChallenge = {}
      getStudentChallenge = ->
        ZuriService.getZooStudent $scope.frId + '/' + $scope.consId, 
          error:(resposne) ->
            return
          success: (response) ->
            personalChallenges = response.data.challenges
            if personalChallenges
              $scope.personalChallenge.id = personalChallenges.current
              $scope.personalChallenge.name = personalChallenges.text
              $scope.personalChallenge.completed = personalChallenges.completed
      getStudentChallenge()
      
      $scope.challenges = []
      ZuriService.getChallenges $scope.frId + '/' + $scope.consId, 
        error: (response) ->
          return
        success: (response) ->
          challenges = response.data.challenges
          angular.forEach challenges, (challenge, challengeIndex) ->
            $scope.challenges.push
              id: challengeIndex + 1
              name: challenge
      
      $scope.updateChallenge = ->
        ZuriService.updateChallenge $scope.frId + '/' + $scope.consId + '?challenge=' + $scope.personalChallenge.id,
          getStudentChallenge()
      
      $scope.logChallenge = ->
        ZuriService.logChallenge $scope.frId + '/' + $scope.consId + '/' + $scope.personalChallenge.id,
          getStudentChallenge()
      
      $scope.skipChallenge = ->
        # TODO
  ] 