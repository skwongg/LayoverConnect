$(document).ready(function(){

  $('.form_submit').on("submit", function(){
      event.preventDefault();
      terminal_num = $('.myselect').val()
      console.log(terminal_num)
      $.ajax({
        url: "http://localhost:3000/terminals/"+terminal_num,
        type: "GET",
        data: $(this).serialize(),
        dataType: 'JSON'
      }).done(function(response){
        $('.klay').empty()

        for(var i = 0; i<response.length; i++){
$('.klay').append('<div class="biz' +response[i].id +'"></div>')
        $('.biz'+response[i].id).append('<p class="f-futura fz-xs m-b-0">' + response[i].name + '</p>')
        $('.biz'+response[i].id).append('<p class="m-t-0">' + response[i].description + '</p>')
        $('.biz'+response[i].id).append("<img class='restaurant' src=" +response[i].image + '>')
       $('.biz'+response[i].id).append("<form class='addevent' method='POST' action=" +"/users/appointment/"+response[i].id+ "><input type='time' name='begin_time' value='08:00:00'></input><input type='time' name='end_time' value='12:00:00'></input><input type='submit' id=" + response[i].id + " value='JOIN'></input></form>")
        // for(var j=0; j<response[i].other_users.length; j++){
        //   $('.biz'+response[i].id).append("<img class='w-50 other_user' src=" +response[i].other_users[j] + '>')
        // }
          }
        // $('#terminal-form').css("display", "none")
      })
  })

  $('.lebron').on("submit",'.addevent', function(){
    event.preventDefault();
    debugger
    $.ajax({
      // url: $(this).attr('action'),
      url: "http://localhost:3001" + $(this).attr('action'),
      method: 'POST',
      data: $(this).serialize(),
      dataType: 'JSON'
    }).done(function(response){
      current.append("<img class='w-50 other_user' src=" +response.profile_picture + '>')
    })


  })

//FIREBASE
// Create a new Firebase reference, and a new instance of the Login client
      // var chatRef = new Firebase('https://radiant-inferno-7960.firebaseio.com/chat');
      // debugger
      // chatRef.onAuth(function(authData) {
      //   // Once authenticated, instantiate Firechat with our user id and user name
      //   if (authData) {
      //     var chat = new FirechatUI(chatRef, document.getElementById('firechat-wrapper'));
      //     chat.setUser(authData.uid, authData[authData.provider].displayName);
      //   }
      // });
      // // debugger
      // function login(provider) {
      //   chatRef.authWithOAuthPopup(provider, function(error, authData) {
      //     if (error) {
      //       console.log(error);
      //     }
      //   });
      // }

//FIREBASE END

// var ref = new Firebase("https://radiant-inferno-7960.firebaseio.com/chat");
// ref.authAnonymously(function(error, authData) {
//   if (error) {
//     console.log("Login Failed!", error);
//   } else {
//     console.log("Authenticated successfully with payload:", authData);
//   }
//   remember: "sessionOnly"
// });



var chatRef = new Firebase("https://radiant-inferno-7960.firebaseio.com/chat");
      var chat = new FirechatUI(chatRef, document.getElementById("firechat-wrapper"));
      chatRef.onAuth(function(authData) {
        if (authData) {
          chat.setUser(authData.uid, "Anonymous" + authData.uid.substr(10, 8));
        } else {
          chatRef.authAnonymously(function(error, authData) {
            if (error) {
              console.log(error);
            }
          });
        }
      });





})