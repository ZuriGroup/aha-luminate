(function ($) {
	$.extend({
		getCustomQuerystring: function(url, name){
		  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
		  var regexS = "[\\?&]" + name + "=([^&#]*)";
		  var regex = new RegExp(regexS);
		  var results = regex.exec(url);
		  if(results == null)
			return "";
		  else
			return decodeURIComponent(results[1].replace(/\+/g, " "));
		}
	});
})(jQuery);

/* amazon pay code here */
var default_path = "https://www2.heart.org";
jQuery(document).ready(function(){
  if (location.href.indexOf("heartdev") > 0) {
    default_path = "https://secure3.convio.net/heartdev";
  }
  if (location.href.indexOf("pg=personal") > 0 || location.href.indexOf("pg=team") > 0) {
		addPaymentOptions();
	}
	if (location.href.indexOf("pagename=heartwalk_participant_center") > 0) {
		addPCPaymentOptions();
	}
	if (location.href.indexOf("Donation2") > 0) {
		if (jQuery.getCustomQuerystring(location.href,"paypal") == "true") {
			angular.element(document.getElementById('ProcessForm')).scope().togglePaymentType('paypal');
		}
	}
});

function addPaymentOptions() {
	if (jQuery('a#sidebar_donate_button').length > 0) {
		var fr_id = jQuery.getCustomQuerystring(location.href,"fr_id");
		var teamid = jQuery.getCustomQuerystring(location.href,"team_id");
		var px = jQuery.getCustomQuerystring(location.href,"px");
    
    /* personal page */
		if (jQuery('body.pg_personal').length > 0) {
			var dlink = jQuery('a#sidebar_donate_button').attr("href");
			var html = "<div class='paymentSelType text-center hidden'><h4>How would you like to donate?</h4>" +
  				"<a href='"+dlink+"'><img src='https://www2.heart.org/images/content/pagebuilder/credit-card-logos2.png'/></a>" +
  				"<a href='"+default_path+"/site/SPageNavigator/cyclenation_donate_amazon.html?FR_ID="+fr_id+"&mfc_pref=T&PROXY_ID="+px+"&PROXY_TYPE=20' class='amazon'><img src='https://donatenow.heart.org/images/amazon-payments_inactive.png'/></a>" +
  				"<a href='"+dlink+"&paypal=true'><img src='https://www2.heart.org/images/content/pagebuilder/PP_logo_h_100x26.png'/></a>";
			jQuery('a#sidebar_donate_button').closest('div').after(html);
			jQuery('a#sidebar_donate_button').click(function(){
				jQuery('.paymentSelType').slideDown();
				return false;
			});
		}

    /* team page */
		if (jQuery('body.pg_team').length > 0) {
		    var dlink = jQuery('a#sidebar_donate_button').attr("href");
  			var html = "<div class='paymentSelType text-center hidden'><h7>How would you like to donate?</h7>"+
		  			 "<a href='"+dlink+"'><img src='https://www2.heart.org/images/content/pagebuilder/credit-card-logos2.png'/></a>" +
		  			 "<a href='"+default_path+"/site/SPageNavigator/cyclenation_donate_amazon.html?FR_ID="+fr_id+"&mfc_pref=T&PROXY_ID="+teamid+"&PROXY_TYPE=22' class='amazon'><img src='https://www2.heart.org/images/content/pagebuilder/amazon-payments.png'/></a>" +
		  			 "<a href='"+dlink+"&paypal=true'><img src='https://www2.heart.org/images/content/pagebuilder/PP_logo_h_100x26.png'/></a>" +
		    		 "</div>";
			jQuery('a#sidebar_donate_button').closest('div').after(html);
			jQuery('a#sidebar_donate_button').click(function(){
				jQuery('.paymentSelType').slideDown();
				return false;
			});
		}
	} else {
		setTimeout(addPaymentOptions,500);
	}
}

function addPCPaymentOptions() {
	if (jQuery('a#make_a_donation').length > 0) {
		var fr_id = jQuery.getCustomQuerystring(location.href,"fr_id");
		var teamid = jQuery.getCustomQuerystring(location.href,"team_id");
		var px = jQuery.getCustomQuerystring(location.href,"px");
	  
		if (location.href.indexOf("pagename=heartwalk_participant_center") > 0) {
		 	jQuery('.profile_box_row').css({"display":"flex"});
			var dlink = jQuery('a#make_a_donation').attr("href");
			var fr_id = jQuery.getCustomQuerystring(location.href,"fr_id");
			var px = jQuery('body').data("cons-id");
			var html = "<div class='paymentSelType hidden' style='clear:both;padding-top:20px;'>" +
						 "<h7>How would you like to donate?</h7>" +
						 "<a href='"+dlink+"'><img src='https://www2.heart.org/images/content/pagebuilder/credit-card-logos2.png'/></a>" +
						 "<a href='"+default_path+"/site/SPageNavigator/jump_hoops_donate_amazon.html?FR_ID="+fr_id+"&mfc_pref=T&PROXY_ID="+px+"&PROXY_TYPE=20' class='amazon'><img src='https://www2.heart.org/images/content/pagebuilder/amazon-payments.png'/></a>" +
						 "<a href='"+dlink+"&paypal=true'><img src='https://www2.heart.org/images/content/pagebuilder/PP_logo_h_100x26.png'/></a>" +
						 "</div>";
			jQuery('a#make_a_donation').closest('.profile_box').append(html);
			jQuery('a#make_a_donation').click(function(e){
				e.preventDefault();
				jQuery('.paymentSelType').slideDown();
				return false;
			});		  
		}

	} else {
		setTimeout(addPCPaymentOptions,500);
	}
}
