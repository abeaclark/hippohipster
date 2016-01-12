
$( document ).ready(function() {


  var player_instance, all_tracks, current_track_index, current_track, current_track_url, current_track_uri, current_track_title, next_track

  // Gather tracks
  SC.get('/users/184375929/tracks').then(function(tracks) {
    all_tracks = tracks;
    current_track_index = 0;
    get_current_track();
    update_title();
    // new_stream();
    // player_instance.pause();
  }); // end Tracks.sc get

  var remove_prefix = function(url) {
    new_uri = url.replace('https://api.soundcloud.com','');
    return new_uri
  };

  var get_current_track = function() {
    current_track = all_tracks[current_track_index];
    current_track_url = current_track['uri'];
    current_track_uri = remove_prefix(current_track_url);
    current_track_title = current_track['title'];
  };


  var new_stream = function() {
    SC.stream(current_track_uri).then(function(player){
      update_title();
      player_instance = player;
      player.seek();
      player_instance.play();
      player_instance.on('finish', this.next_track())

    }); // end SC.stream
  };


  $('#pause').click(function(e) {
    e.preventDefault();
    player_instance.pause();
  });


  $('#play').click(function(e) {
    e.preventDefault();
    new_stream()
    player_instance.play();
  });

  var next_track = function() {
    current_track_index === (all_tracks.length -1)? (current_track_index = 0) : (current_track_index += 1)
    get_current_track()
    new_stream()
  };

  var previous_track = function() {
    current_track_index === 0 ? (current_track_index = all_tracks.length -1) : (current_track_index -= 1)
    get_current_track()
    new_stream()
  };

  var update_title = function() {
    $('#title').html(current_track_title);
  };


  $('#back').click(function(e) {
    e.preventDefault();
    previous_track()
  });

  $('#forward').click(function(e) {
    e.preventDefault();
    next_track()
  });


  // form controls

$('#sign_up').submit(function(e) {
    e.preventDefault()
    $.ajax({
        url: "https://docs.google.com/forms/d/1OlFEoQnno19JdI0LPMsRm4jLdQ6ZV6GSOlsVWRhanms/formResponse",
        data: $(this).serialize(),
        type: "POST",
        dataType: "xml",
        success: function(data) {
            console.log('Submission successful');
        },
        error: function(xhr, status, error) {
            console.log('Submission failed: ' + error);
        }
    });


    $('.connect').html('<span class="invite"> Good Decision </span><span class="invite"> Now, tell your friends. </span>');
  });

  // video controls

  $('#click_vid_start').click(function(e) {
    e.preventDefault()

    // stop music if it is playing
    if (typeof player_instance != "undefined") {
    player_instance.pause();
    }

    $('#jumbo_3').css('background-image', 'none');
    $('#play_video').remove();
    $('#video_1').show()
    $('#video_1').attr('src', $("#video_1").attr('src') + '&autoplay=1');
  });

  // smooth scroll
    $('a[href*=#]:not([href=#])').click(function() {
    if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
      if (target.length) {
        $('html,body').animate({
          scrollTop: target.offset().top
        }, 1000);
        return false;
      }
    }
  });


}); // end document.ready
