function luhnCheckSum(cardNumber){var sum=0;var digit=0;var addend=0;var timesTwo=false;for(var i=cardNumber.length-1;i>=0;i--){digit=parseInt(cardNumber.charAt(i));if(timesTwo){addend=digit*2;if(addend>9){addend-=9;}}else{addend=digit;}
sum+=addend;timesTwo=!timesTwo;}
return sum%10==0;}
function checkCardNoLength(cardNumber){if(cardNumber.length>=13&&cardNumber.length<=16){return true;}
return false;}
function checkBindChinnelCardType(cardNumber){alert(cardNumber);var firstDigit=cardNumber.charAt(0);var isExistCard=false;if(cartypes[4]=="VISA"){if(firstDigit==4){isExistCard=true;}}
if(cartypes[5]=="MASTER"){if(firstDigit==5||firstDigit==2){isExistCard=true;}}
if(firstDigit==3){var cardNo1=cardNumber.substring(0,2);if(cartypes[3]=="JCB"){if(cardNo1==35){isExistCard=true;}}
if(cartypes[6]=="AE"){if(cardNo1==34||cardNo1==37){isExistCard=true;}}}
if(!isExistCard){return false;}
return true;}
function checkCvvLength(cvv){if(cvv.length==3||cvv.length==4){return true;}
return false;}
function checkCvvFormat(cvv){var reg=/^[0-9]+$/;if(cvv.match(reg)){return true;}
return false;}