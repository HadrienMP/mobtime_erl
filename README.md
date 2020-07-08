```
|#############################--|
|    _______  _____  ______     |
|    |  |  | |     | |_____]    |
|    |  |  | |_____| |_____]    |
| _______ _____ _______ _______ |
|    |      |   |  |  | |______ |
|    |    __|__ |  |  | |______ |
|                               |
|#################--------------|
 3min left in turn
```

mobtime
=====

A front as a console app written in erlang. It is an escript built with escriptize from rebar.

Build
-----

    $ rebar3 escriptize

Run
---

    $ _build/default/bin/mobtime $YOUR_MOB_NAME

Where $YOUR_MOB_NAME is the name of the mob in mob time server.


Manual
------
For now there is now embedded manual, and magic keys enable you to interact with mob time.  
Press :  
- r, to start a turn (like run)
- k, to stop a turn (like kill)
- p, to stop a pomodoro (like pomodoro)
