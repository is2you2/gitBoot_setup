void setup(){
  surface.setVisible(false);
  println("Boot_setup: server git setting");
  File files=new File(sketchPath());
  
  StringList tmpDir=new StringList(),
    result=new StringList();
    
  for(int i=files.listFiles().length-1;i>=0;i--)
    if(files.listFiles()[i].isDirectory())
      if(hasGit(files.listFiles()[i]))
        tmpDir.append(files.listFiles()[i].toString());
  println("Total: ",tmpDir.size());
  result.append("echo \"boot_setup start\"");
  result.append("sudo service apache2 restart");
  result.append("eval `ssh-agent -s`");
  result.append("ssh-add ~/.ssh/your_key");
    for(int i=0,j=tmpDir.size();i<j;i++){
      result.append("cd "+tmpDir.get(i));
      result.append("git config --bool core.bare true");
      result.append("echo \"core.bare_true: "+tmpDir.get(i)+"\"");
      result.append("cd ~");
    }
  result.append("echo \"boot_setup complete progress\"");
  result.append("rm run.bash");
  saveStrings("run.bash",result.array());
  exit();
}

private boolean hasGit(File dir){
  boolean result=false;
  for(int i=0,j=dir.listFiles().length;i<j;i++)
    if(dir.listFiles()[i].toString().indexOf(".git")==0){
      println("has .git folder, add order: ", dir);
      result=true;
      break;
    }
  
  return result;
}
