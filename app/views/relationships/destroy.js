$("#following").html("<%= escape_javascript(render 'shared/follow', :user => @user) %>");
loader.stop();