// bug-report & contact : Telegram @is2you2
// import processing.net.*;

void setup(){
  StringList shellResult=new StringList();
  shellResult.append("echo \"auto create shell end.\"");
  shellResult.append("sleep 2");
  shellResult.append("eval `ssh-agent -s`");
  
  // get ssh-keys
  { File ssh=new File("/home/ubuntu/.ssh/");
    File[] tmp=ssh.listFiles();
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
  // getWork: auto extract & init git
  File main=new File("/home/ubuntu/");
  { File[] tmp=main.listFiles();
    StringList getDir=new StringList() // catch gitDir+.zip
      ,inited=new StringList(); // will know it has git already
    for(int i=0,j=tmp.length;i<j;i++){
      String tmpString=tmp[i].toString();
      String fileName=tmpString.substring(tmpString.lastIndexOf('/'));
      String fileType=tmpString.substring(fileName.lastIndexOf('.'));
      if(fileName.indexOf("gitDir+")==0 && fileType.indexOf("zip")==0)
        getDir.append(tmpString);
      if(hasGit(tmp[i])) // get inited
        inited.append(tmpString);
    }
    print("getDir zip: ");
    printArray(getDir);
    for(int i=0,j=getDir.size();i<j;i++){ // unzip list
      String tmpString=tmp[i].toString();
      String fileName=tmpString.substring(tmpString.lastIndexOf('/'));
      shellResult.append("unzip "+fileName);
      shellResult.append("rm -rf "+fileName+" .DS_Store __MACOSX Thumbs.db"); // delete file
      shellResult.append("cd "+fileName.substring(0,fileName.lastIndexOf('.')));
      shellResult.append("echo \".DS_Store\" > .gitignore");
      shellResult.append("echo \"__MACOSX\" > .gitignore");
      shellResult.append("echo \"Thumbs.db\" > .gitignore");
      shellResult.append("echo \"*.tmp\" > .gitignore");
      shellResult.append("echo \"*.tmp.*\" > .gitignore");
      shellResult.append("echo \"*.log\" > .gitignore");
      shellResult.append("git init"); // init from here
      shellResult.append("git remote add origin "+"ip_address"+":"+fileName.substring(0,fileName.lastIndexOf('.'))); // how to get host ip address
      shellResult.append("git add .");
      shellResult.append("git commit -m \"serverSide autoCommit\"");
      shellResult.append("git push --set-upstream origin master");
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
  File[] tmp=dir.listFiles();
  for(int i=0,j=tmp.length;i<j;i++)
    if(tmp[i].toString().indexOf(".git")==0){
      println("has .git folder, add order: ", tmp[i]);
      result=true;
      break;
    }else{
      println("has no .git: ",tmp[i]);
    }
  return result;
}