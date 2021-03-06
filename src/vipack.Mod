MODULE vipack;
IMPORT  Texts, Strings, Oberon, Out,
  vpkConf, vpkLogger, vpkSyncer, vpkInstaller, StringList;

PROCEDURE help();
BEGIN
	vpkLogger.Log("HelpText");
	Out.String("Vipack sync - syncing git tree and local tree"); Out.Ln;
	Out.String("vipackConf.json path -> $HOME/.vipack/vipackConf.son"); Out.Ln;
	Out.String("vipackTree path -> $HOME/.vipack/vipackTree")
END help;

PROCEDURE  main();
VAR  
	S: Texts.Scanner;
  unit, command: ARRAY 64 OF CHAR; (* because Texts.Scanner.s is 64 bytes long*)
BEGIN
  (* this could go to vpkConf init section, 
  but here it is more visible. though may be it doesn't have to be *)
  IF ~vpkConf.configured() THEN vpkConf.mkDefConfig END; 

  (* Getting 1 argument and outputting it *)
  Texts.OpenScanner(S, Oberon.Par.text, Oberon.Par.pos);
  Texts.Scan(S);

  command := S.s;

  IF Strings.Match(command, "") OR Strings.Match(command, "help")THEN
	  help;
  ELSE 

    IF command = "sync" THEN
      vpkSyncer.sync;
	  END;

	  IF command = "install" THEN
		  Texts.Scan(S);
		  unit := S.s;
		  vpkInstaller.install(unit);
	  END;

  END;
END main;

BEGIN
  main
END vipack.
