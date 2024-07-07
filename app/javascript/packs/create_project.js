$(document).on("turbolinks:load", function() {
  console.log("create_project.js loaded");

  $(document).on('click', '#create-project', function(e) {
    e.preventDefault();
    console.log("Create Project button clicked");
    
    if (!userSignedIn()) {
      alert('You need to sign in to the app to create a project');
    } else {
      // Handle project creation for signed-in users
      console.log("User is signed in, proceed with project creation");
    }
  });
});

function userSignedIn() {
  // Replace this with actual logic to check if user is signed in
  return $('body').data('userSignedIn') === true;
}