// bug-report & contact : Telegram @is2you2
// import processing.net.*;

void setup(){
  StringList shellResult=new StringList();
  shellResult.append("echo \"auto create shell end.\"");
  shellResult.append("sleep 2");
  shellResult.append("eval `ssh-agent -s`");
  
  // get ssh-keys inside ~/.ssh/*.pem
  println("ssh-keys part start");
  { final File ssh=new File("/home/ubuntu/.ssh/");
    print("ssh folder: ");
    printArray(ssh);
    final File[] tmp=ssh.listFiles();
    StringList sshKeys=new StringList();
    for(int i=0,j=tmp.length;i<j;i++)
      if(tmp[i].toString().indexOf(".pem")>=0)
        sshKeys.append(tmp[i].toString());
    print("get ssh-keys: ");
    printArray(sshKeys);
    for(int i=0,j=sshKeys.size();i<j;i++)
      shellResult.append("ssh-add "+sshKeys.get(i));
    shellResult.append("echo \"add ssh-keys from ~/.ssh\"");
    shellResult.append("sleep 1");
  }
  println("ssh-add part end");
  // getWork: auto extract & init git
  println("getWork start");
  File main=new File("/home/ubuntu/");
  { final File[] tmp=main.listFiles();
    StringList getDir=new StringList() 
      ,inited=new StringList(); // will know it has git already
    for(int i=0,j=tmp.length;i<j;i++){
      final String tmpString=tmp[i].toString();
      final String fileName=tmpString.substring(tmpString.lastIndexOf('/')+1);
      final String fileType=tmpString.substring(fileName.length()-3);
      if(fileType.indexOf("zip")>0)
        getDir.append(tmpString);
      if(hasGit(tmp[i])) // get inited
        inited.append(tmpString);
    }
    println("getWork end");
    print("getDir zip: ");
    printArray(getDir);
    for(int i=0,j=getDir.size();i<j;i++){ // unzip list
      final String tmpString=getDir.get(i).toString();
      final String fileName=tmpString.substring(tmpString.lastIndexOf('/')+1);
      println("unzip "+fileName);
      shellResult.append("unzip "+fileName);
      shellResult.append("rm -rf "+fileName+" .DS_Store __MACOSX Thumbs.db"); // delete file
      println("unzip this~:",fileName.substring(0,fileName.lastIndexOf('.')));
      shellResult.append("cd "+fileName.substring(0,fileName.lastIndexOf('.')));
      shellResult.append("git remote add origin "+"0.0.0.0"+":"+fileName.substring(0,fileName.lastIndexOf('.'))); // how to get host ip address
      shellResult.append("git add .");
      shellResult.append("git commit -m \"serverSide autoCommit\"");
      shellResult.append("git push --set-upstream origin master");
      shellResult.append("git config --bool core.bare true");
      shellResult.append("cd ~");
    }
  }
  { // auto init all folders
    final File[] tmp=main.listFiles();
    StringList dirList=new StringList();
    for(int i=0,j=tmp.length;i<j;i++)
      if(hasGit(tmp[i]))
        dirList.append(tmp[i].toString());
    print("git config folders: ");
    printArray(dirList);
    shellResult.append("sleep 1");
    for(int i=0,j=dirList.size();i<j;i++){
      shellResult.append("cd "+dirList.get(i));
      shellResult.append("git config --bool core.bare true");
      shellResult.append("cd ~");
    }
  }
  shellResult.append("rm run.sh");
  saveStrings("run.sh",shellResult.array());
  exit();
}

private boolean hasGit(File dir){
  boolean result=false;
  if(dir.isDirectory()){
    final File[] tmp=dir.listFiles();
    for(int i=0,j=tmp.length;i<j;i++)
      if(tmp[i].toString().indexOf(".git")==0){
        println("has .git folder, add order: ", tmp[i]);
        result=true;
        break;
      }
  }
  return result;
}
