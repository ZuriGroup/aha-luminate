angular.module 'ahaLuminateControllers'
  .controller 'DonationCtrl', [
    '$scope'
    '$rootScope'
    '$location'
    'DonationService'
    ($scope, $rootScope, $location, DonationService) ->      
      $scope.paymentInfoErrors = 
        errors: []
      angular.element('.page-error').remove()
      $fieldErrors = angular.element '.ErrorMessage'
      angular.forEach $fieldErrors, (fieldError) ->
        $fieldError = angular.element fieldError
        if $fieldError.find('.field-error-text').length > 0
          fieldErrorText = jQuery.trim $fieldError.find('.field-error-text').text()
          $scope.paymentInfoErrors.errors.push
            text: fieldErrorText
      
      $errorContainer = angular.element '.form-error'
      angular.forEach $errorContainer, (error) ->
        $error = angular.element error
        angular.element($error).addClass 'has-error'
        angular.element($error).removeClass 'form-error'
      
      $scope.donationInfo = 
        validate: 'true'
        form_id: angular.element('#df_id').val()
        fr_id: angular.element('#FR_ID').val()
        billing_text: angular.element('#billing_info_same_as_donor_row label').text()
        giftType: 'onetime'
        monthly: false
        amount: ''
      
      $scope.donationLevels = []

      $scope.installment = [
        number: ''
        amount: ''
      ]
      

      document.getElementById('level_installmentduration').onchange = ->
        console.log 'change'
        number = document.getElementById('level_installmentduration').value
        number = number.split(':')[1]
        amount = angular.element('#level_installmenttotal_row .donation-level-total-amount').text()
        $scope.installment.number = number
        $scope.installment.amount = amount

      $scope.giftType = (type) ->  
        $scope.donationInfo.giftType = type    
        if type is 'monthly'
          angular.element('.ym-donation-levels__type--onetime').removeClass 'active'
          angular.element('.ym-donation-levels__type--monthly').addClass 'active'
          angular.element('#level_installment_row').removeClass 'hidden'
          angular.element('#pstep_finish span').remove()
          $scope.donationInfo.monthly = true
          console.log $scope.installment
        else
          angular.element('.ym-donation-levels__type--onetime').addClass 'active'
          angular.element('.ym-donation-levels__type--monthly').removeClass 'active'
          angular.element('#level_installment_row').addClass 'hidden'
          angular.element('#level_installmentduration').val 'S:0'
          $scope.donationInfo.monthly = false
          

      $scope.selectLevel = (type, level, amount) ->        
        angular.element('.ym-donation-levels__amount .btn-toggle.active').removeClass 'active'
        angular.element('.ym-donation-levels__amount .btn-toggle.level' + level).addClass 'active'
        angular.element('.ym-donation-levels__message').removeClass 'active'
        angular.element('.ym-donation-levels__message.level' + level).addClass 'active'
        angular.element('.donation-level-container.level' + level + ' input').click()
        populateBtnAmt(type, level, amount)
        $scope.donationInfo.amount = amount

      
      $scope.enterAmount = (amount) ->
        angular.element('#pstep_finish span').text ''
        angular.element('#pstep_finish span').prepend('$' + amount)
        angular.element('.donation-level-user-entered input').val amount
        $scope.donationInfo.amount = amount

      populateBtnAmt = (type, level, amount) ->
        angular.element('#pstep_finish span').remove()
        if $scope.donationInfo.giftType == 'onetime'
          if type is 'level'
            levelAmt = ' <span>' + amount + ' <i class="fa fa-chevron-right" aria-hidden="true"></i></span>'
            angular.element('#pstep_finish').append levelAmt
          else
            angular.element('#pstep_finish').append '<i class="fa fa-chevron-right" aria-hidden="true"></i></span>'
      
      employerMatchFields = ->
        angular.element('#employer_name_row').parent().addClass 'ym-employer-match__fields'
        angular.element('#employer_street_row').parent().addClass 'ym-employer-match__fields'
        angular.element('#employer_city_row').parent().addClass 'ym-employer-match__fields'
        angular.element('#employer_state_row').parent().addClass 'ym-employer-match__fields'
        angular.element('#employer_zip_row').parent().addClass 'ym-employer-match__fields'
        angular.element('#employer_phone_row').parent().addClass 'ym-employer-match__fields'
        angular.element('.employer-address-container').addClass 'hidden'
        angular.element('.matching-gift-container').addClass 'hidden'
        angular.element('label[for="match_checkbox_dropdown"]').parent().parent().parent().addClass('ym-employer-match')
        empCheck = angular.element('#match_checkbox_radio').prop 'checked'
        if empCheck == true
          angular.element('.ym-employer-match__message').removeClass 'hidden'
          angular.element('.matching-gift-container').removeClass 'hidden'

      document.getElementById('match_checkbox_radio').onclick = ->
        angular.element('.ym-employer-match__message').toggleClass 'hidden'
        angular.element('.matching-gift-container').toggleClass 'hidden'         
      $scope.toggleEmployerMatch = ->
        console.log 'click'
        angular.element('.ym-employer-match__message').toggleClass 'hidden'
        angular.element('.matching-gift-container').toggleClass 'hidden'
      
      donorRecognitionFields = ->
        angular.element('#tr_show_gift_to_public_row').addClass 'hidden ym-donor-recognition__fields'
        angular.element('#tr_recognition_nameanonymous_row').addClass 'hidden ym-donor-recognition__fields'
        angular.element('#tr_recognition_namerec_name_row').addClass 'hidden ym-donor-recognition__fields'
      
      $scope.toggleDonorRecognition = ->
        angular.element('.ym-donor-recognition__fields').toggleClass 'hidden'
      
      $scope.togglePersonalNote = ->
        angular.element('#tr_message_to_participant_row').toggleClass 'hidden ym-border'
      
      $scope.tributeGift = (type) ->
        if type is 'honor'
          angular.element('.btn-toggle--honor').toggleClass 'active'
          
          if angular.element('.btn-toggle--honor').is '.active'
            angular.element('.btn-toggle--memory').removeClass 'active'
            angular.element('#tribute_type').val 'tribute_type_value2'
            angular.element('#tribute_show_honor_fieldsname').prop 'checked', true
            angular.element('#tribute_honoree_name_row').show()
          else
            angular.element('#tribute_type').val ''
            angular.element('#tribute_show_honor_fieldsname').prop 'checked', false
            angular.element('#tribute_honoree_name_row').hide()
        else
          angular.element('.btn-toggle--memory').toggleClass 'active'
          
          if angular.element('.btn-toggle--memory').is '.active'
            angular.element('.btn-toggle--honor').removeClass 'active'
            angular.element('#tribute_type').val 'tribute_type_value1'
            angular.element('#tribute_show_honor_fieldsname').prop 'checked', true
            angular.element('#tribute_honoree_name_row').show()
          else
            angular.element('#tribute_type').val ''
            angular.element('#tribute_show_honor_fieldsname').prop 'checked', false
            angular.element('#tribute_honoree_name_row').hide()
      
      billingAddressFields = ->
        angular.element('#billing_first_name_row').addClass 'billing-info'
        angular.element('#billing_last_name_row').addClass 'billing-info'
        angular.element('#billing_addr_street1_row').addClass 'billing-info'
        angular.element('#billing_addr_street2_row').addClass 'billing-info'
        angular.element('#billing_addr_city_row').addClass 'billing-info'
        angular.element('#billing_addr_state_row').addClass 'billing-info'
        angular.element('#billing_addr_zip_row').addClass 'billing-info'
        angular.element('#billing_addr_country_row').addClass 'billing-info'
        angular.element('.billing-info').addClass 'hidden'

      $scope.togglePaymentType = (paymentType) ->
        if paymentType == 'paypal'
          angular.element('#responsive_payment_typepay_typeradiopaypal').click()
          angular.element('#payment_cc_container').hide()
          angular.element('.btn--credit').removeClass('active')
          angular.element('.btn--paypal').addClass('active')
        else
          angular.element('#responsive_payment_typepay_typeradiocredit').click()
          angular.element('#payment_cc_container').show()
          angular.element('.btn--credit').addClass('active')
          angular.element('.btn--paypal').removeClass('active')

      $scope.toggleBillingInfo = ->
        angular.element('.billing-info').toggleClass 'hidden'
        inputStatus = angular.element('#billing_info').prop 'checked'
        
        if inputStatus is true
          angular.element('#billing_info_same_as_donorname').prop 'checked', true
        else
          angular.element('#billing_info_same_as_donorname').prop 'checked', false
      
      loadForm = ->
        DonationService.getDonationFormInfo 'form_id=' + $scope.donationInfo.form_id + '&fr_id=' + $scope.donationInfo.fr_id
          .then (response) ->
            levels = response.data.getDonationFormInfoResponse.donationLevels.donationLevel
            
            angular.forEach levels, (level) ->
              levelId = level.level_id
              amount = level.amount.formatted
              amount = amount.split('.')[0]
              userSpecified = level.userSpecified
              inputId = '#level_installmentexpanded' + levelId
              classLevel = 'level' + levelId
              
              angular.element(inputId).parent().parent().parent().parent().addClass classLevel
              
              levelLabel = angular.element('.' + classLevel).find('.donation-level-expanded-label p').text()
              
              levelChecked = angular.element('.' + classLevel + ' .donation-level-label-input-container input').prop 'checked'

              if levelChecked is true
                $scope.donationInfo.amount = amount
              
              $scope.donationLevels.push
                levelId: levelId
                classLevel: classLevel
                amount: amount
                userSpecified: userSpecified
                levelLabel: levelLabel
                levelChecked: levelChecked
        
        optional = '<span class="ym-optional">Optional</span>'       
        angular.element('#donor_phone_row label').append optional
        angular.element('#tr_message_to_participant_row').addClass 'hidden'
        angular.element('#billing_info').parent().addClass 'billing_info_toggle'
        angular.element('#payment_cc_container').append '<div class="clearfix" />'
        angular.element('#responsive_payment_typecc_cvv_row .FormLabelText').text 'CVV:'
        angular.element('#level_installment_row').addClass 'hidden'

        angular.element('#tr_recognition_namerec_namename').attr('placeholder', 'If different from your name')
        angular.element('#tr_message_to_participantname').attr('placeholder', 'Write a message of encouragement. 255 characters max.')
        employerMatchFields()
        billingAddressFields()
        donorRecognitionFields()

      loadForm()
      console.log $scope.donationInfo

      if $scope.donationInfo.monthly is false
        console.log 'test' + $scope.donationInfo.amount
        
        angular.element('.finish-step').append('<span><i class="fa fa-chevron-right" aria-hidden="true"></i></span>')
  ]