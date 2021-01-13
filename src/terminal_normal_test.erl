%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(terminal_normal_test).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").

%% --------------------------------------------------------------------



%% External exports
-export([start/0
	]).



%% ====================================================================
%% External functions
%% ====================================================================
test_terminals()->
    [misc_oam:node("terminal"),
     misc_oam:node("2_log_terminal"),
     misc_oam:node("glurk")].
     
    

%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
start()->
    ?debugMsg("Start setup"),
    ?assertEqual(ok,setup()),
    ?debugMsg("stop setup"),
    
    ?debugMsg("Start test_1"),
    ?assertEqual(ok,test_1()),
    ?debugMsg("stop test_1"),

    ?debugMsg("Start test_2"),
    ?assertEqual(ok,test_2()),
    ?debugMsg("stop test_2"),

%    ?debugMsg("Start test_3"),
%    ?assertEqual(ok,test_3(2000)),
%    ?debugMsg("stop test_3"),
    
   
      %% End application tests
    ?debugMsg("Start cleanup"),
    ?assertEqual(ok,cleanup()),
    ?debugMsg("Stop cleanup"),

    ?debugMsg("------>"++atom_to_list(?MODULE)++" ENDED SUCCESSFUL ---------"),
    ok.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
test_3(0)->
    ok;
test_3(N) ->
    logger:alert("Alert"),
    logger:notice("Notice"),
    logger:info("Info"),
    zz:alert("Alert out of disc ~n"),
    test_3(N-1).
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
test_2()->
    %% crash nodes 
    Date=date(),
    ?assertMatch({[{badrpc,_},{badrpc,_}],
		  ['glurk@c2']},rpc:multicall(test_terminals(),erlang,date,[glurk],1000)),
    
    ?assertMatch({[ok,ok],['glurk@c2']},
		 rpc:multicall(test_terminals(),terminal,print,["Survived the crash test ~n"])),
    
    
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
test_1()->
 
    Date=date(),
    ?assertMatch({[Date,Date],
		  ['glurk@c2']},rpc:multicall(test_terminals(),erlang,date,[],1000)),
    
    
    ?assertMatch({[ok,ok],['glurk@c2']},
		 rpc:multicall(test_terminals(),terminal,print,["Text1 ~n"])),
    
    ?assertMatch({[ok,ok],['glurk@c2']},
		   rpc:multicall(test_terminals(),terminal,print,["Text1 ~p~n",[{node(),?MODULE,?LINE}]])),

    ?assertMatch(['terminal@c2'],
		 misc_oam:get_log_terminals()),
    
    
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
setup()->
  
    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------    

cleanup()->
  
    init:stop(),
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
