<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="/pschat/bower_components/materialize/dist/css/materialize.min.css"  media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="/pschat/bower_components/izitoast/dist/css/iziToast.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <style>
            .card-chat {
                margin: 0 auto !important;
                width: 100vw;
                height: 100vh !important;
            }
            .chatters {
                margin: 0px !important;
                border-right: 0.5px solid rgba(0, 0, 0, 0.1);
                overflow-y: auto;
                overflow-x: hidden;
                height: 65vh;
            }

            .card-action {
                overflow: hidden;
                height: 18vh !important;
                padding: 5px !important;
            }

            .chat-content {
                margin-bottom: 0px !important;
                height: 65vh !important;
            }


            .custom-row {
                margin: 0px !important;
            }

            .send-button {
                top: 40px;
            }

            .messages {
                height: 65vh !important;
                overflow-y: auto;
            }

            .alone-message {
                border-radius: 7px;
                padding: 8px;
                display: table;
                margin: 5px;
            }

            @media only screen and (max-width: 600px) {
                .chatters {
                    height: 20vh !important;
                }
                .card-action {
                    overflow: hidden;
                    height: 18vh !important;
                    padding: 5px !important;
                }
                .messages {
                    height: 40vh !important;
                }
            } 
        </style>
    </head>
    <body>
        <div class="pschat-container">                
            <div class="card card-chat darken-1">
                <div class="card-content blue-grey white-text">
                    <span class="card-title">PSChat</span>
                </div>
                <div class="chat-content row custom-row">
                    <div class="col s12 m2">
                        <div class="chatters">
                            <h5 class="center-align">Povão conectado</h5>
                            <div class="center-align nicknames">

                            </div>
                        </div>
                    </div>
                    <div class="col s12 m10">
                        <div class="messages">

                        </div>
                    </div>
                </div>
                <div class="card-action custom-row">
                    <div class="row custom-row messaging">
                        <form autocomplete="off" id="form-message">
                            <div class="input-field col s10">
                                <textarea id="message" class="materialize-textarea flow-text" name="message" placeholder="Digite uma mensagem" rows="1"></textarea>
                            </div>
                            <div class="col s2 center-align">
                                <button class="btn-floating waves-effect darken-1 send-button" title="Enviar" type="submit"><i class="material-icons">send</i></button>
                            </div>
                            <input type="hidden" value="<%= request.getSession().getAttribute("nickname")%>" name="chatter"/>
                        </form>
                    </div>
                </div>
            </div>          
        </div>     
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="/pschat/bower_components/jquery/dist/jquery.min.js"></script>
        <script type="text/javascript" src="/pschat/bower_components/materialize/dist/js/materialize.min.js"></script>
        <script type="text/javascript" src="/pschat/bower_components/izitoast/dist/js/iziToast.min.js"></script>
        <script>
            $(function () {
                var mynick = "<%= request.getSession().getAttribute("nickname")%>";
                var rtconnection = new WebSocket("ws://" + window.location.host + window.location.pathname);

                rtconnection.onmessage = function (message) {
                    var j = JSON.parse(message.data);

                    if (j.type != undefined && j.type === "newchatter") {
                        getChatters();
                    } else {
                        var side, brightness;
                        if (j.chatter === mynick) {
                            side = "right";
                            brightness = "lighten-4";
                        } else {
                            side = "left";
                            brightness = "lighten-5";
                        }
                        var m = $("<div class='custom-row row'><div style='opacity: 0;' class='alone-message blue-grey " + brightness + " " + side + "'><h6 style='margin: 5px; text-transform: uppercase;'>" + j.chatter + "</h6><p>" + j.message.replace(/astnlast/g, "<br/>") + "</p></div></div>");
                        $(".messages").append(m).scrollTop($(".messages").height());
                        m.find(".alone-message").animate({opacity: 1}, 400);
                    }
                }

                var chatters = [];
                function getChatters() {
                    $.ajax("/pschat/chatters", {
                        success: function (data) {
                            var j = JSON.parse(data);
                            if (j.status == 1) {
                                $(".nicknames").html("");
                                $.each(j.chatters, function (index, element) {
                                    $(".nicknames").append('<div class="chip center-align">\
                                        ' + element.nickname + '\
                                      </div><br/>');
                                });
                            }
                        },
                        cache: false
                    });
                }
                ;

                iziToast.show({position: "topCenter", title: '<%=request.getSession().getAttribute("nickname")%>,', message: "Este será seu apelido."});


                var message = $("textarea#message");
                message.on("keypress", function (e) {
                    if (e.keyCode === 13 && !e.shiftKey) {
                        shouldSend(message);
                    }
                });

                var form = $("#form-message");
                form.on("submit", function (e) {
                    e.preventDefault();
                    shouldSend($("[name='message']"));
                });

                message.focus();
            });

            function shouldSend(message) {
                var val = message.val();
                if (val === undefined || val === "") {
                    message.val('').blur();
                    setTimeout(function () {
                        message.focus();
                    }, 10);
                    return false;
                } else {
                    $.ajax("/pschat/talk/private/secure/chat/send", {
                        method: "POST",
                        data: $("form#form-message").serialize(),
                        complete: function (data) {
                            message.val('').blur();
                            message.focus();
                        }
                    });
                }
            }
        </script>
    </body>
</html>
