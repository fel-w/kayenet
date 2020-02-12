//Function to cross-check the two passwords from the account create-account.jsp form
function passwordValidate(){
  //Why can't javascript obtained variables be declared globally??!
  
  var password = document.forms["create-account.jsp"]["password"].value; /*Variable to pick original password from the form*/
  var confirmPass = document.forms["create-account.jsp"]["confirmPass"].value; /*Variable to pick the confirmatory password from the form*/
  if (confirmPass != password){
      document.getElementById("passwordError").innerHTML = "Passwords do not match!";
  }else{
      document.getElementById("passwordError").innerHTML = "";
      document.getElementById("passwordError2").innerHTML = "";
  }
}    

//Confirming before a delete
function confirmDelete() {
  confirm("Please Confirm to Delete");
}