//unzip gitDir+repositoryname.zip
//rm gitDir+repositoryname.zip
//mv gitDir+repositoryname repositoryname
//cd repositoryname
//git init
//git remote add origin address
//git init --bare
//git config --bool core.bare true
//git add .
//git commit -m "firstCommit"
//git push --set-upstream origin master
void setup(){
  File files=new File("/home/ubuntu/");
  StringList task=new StringList(),
    result=new StringList();
  for(int i=0,j=files.listFiles().length;i<j;i++)
    if(files.listFiles()[i].toString().indexOf("gitDir+")>=0){
      task.append(files.listFiles()[i].toString());
      println("add task:",files.listFiles()[i].toString());
    }
  printArray(task);
  for(int i=0,j=task.size();i<j;i++){
    String[] tmpName=split(task.get(i),'/');
    String zipName=tmpName[tmpName.length-1];
    result.append("unzip "+zipName);
    result.append("rm "+zipName);
    String tmpgitName=zipName.substring(0,zipName.length()-4);
    String name=tmpgitName.substring(7);
    result.append("mv "+tmpgitName+" "+name);
    result.append("cd "+name);
    result.append("eval `ssh-agent -s`");
    result.append("ssh-add ~/.ssh/your_key");
    result.append("git init");
    result.append("git init --bare");
    result.append("git config --bool core.bare true");
    result.append("git remote add origin ubuntu@ip_address:"+name);
    result.append("git add .");
    result.append("git commit -m \"serverSide firstCommit\"");
    result.append("git push --set-upstream origin master");
    result.append("cd ~");
  }
  saveStrings("initGit.sh",result.array());
  exit();
}
