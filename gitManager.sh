# @0.0.0.0 <- 이 문구를 확인하여 서버 ip주소로 바꾸셔야 합니다.
# origin 재설정됩니다. 참고...*

ssh-add ~/.ssh/*.pem
while :
do
    clear
    echo ""
    cat<<EOF
    ======================================
                 Git 저장소 작업
    --------------------------------------
    작업 번호를 입력해주세요 :

    1) 저장소에 새 프로젝트를 등록하기
    2) 저장소에서 기존 프로젝트를 가져오기
        q)uit - 나가기
    --------------------------------------
EOF
    read -n1 -s
    case "$REPLY" in
    "1")  echo ""
    echo "새 프로젝트를 등록할 예정입니다."
    echo ""
    ls
    echo ""
    read -e -p "등록할 프로젝트 폴더 이름을 적어주세요. (대소문자 구분 필요해요) : " NAME
    if [$NAME == ""];
    then
    echo ""
    echo "이름 자리에 공란이 되면 안되어요 ... !"
    echo ""
    exit
    fi
    echo ""
    echo "   등록할 프로젝트 폴더 이름은 $NAME"
    echo "* 등록 진행 중에 파일을 수정 하거나 이 터미널을 종료하면 곤란해요!"
    sleep 5
    echo ""
    echo "등록 작업 시작!"
    ssh ubuntu@0.0.0.0 "ssh-add ~/.ssh/*;mkdir $NAME;cd $NAME;git init;git remote add origin ubuntu@0.0.0.0:$NAME;git config --bool core.bare true;git remote -v"
    echo ""
    echo ""
    echo "등록 작업 끝!"
    echo ""
    echo "해당 프로젝트를 서버에 동기화합니다.."
    echo ""
    cd $NAME
    git remote remove origin
    git remote add origin ubuntu@0.0.0.0:$NAME
    git remote -v
    git push --set-upstream origin master
    cd ..
    echo ""
    echo "서버측 폴더 확인:"
    ssh ubuntu@0.0.0.0 ls -l | grep $NAME
    echo ""
    echo "이 컴퓨터의 폴더 확인:"
    ls -l | grep $NAME
    echo ""
    echo "확인해주세요 :D"
    echo ""
    exit
    ;;
    "2")  echo ""
    echo "저장소에서 기존 프로젝트를 가져올 예정입니다."
    ssh ubuntu@0.0.0.0 ls
    echo ""
    read -e -p "불러올 프로젝트의 이름을 적어주세요. (대소문자 구분 필요해요) : " NAME
    if [$NAME == ""];
    then
    echo ""
    echo "이름 자리에 공란이 되면 안되어요 ... !"
    echo ""
    exit
    fi
    echo ""
    echo "가져올 프로젝트의 이름은 $NAME"
    sleep 1
    echo ""
    ssh ubuntu@0.0.0.0 git config --global pack.windowMemory 256m
    git clone ubuntu@0.0.0.0:$NAME
    echo ""
    echo "프로젝트 불러오기 끝!"
    echo ""
    echo "불러온 프로젝트의 위치 확인:"
    echo ""
    pwd
    ls -l | grep $NAME
    echo ""
    echo "확인해주세요. :)"
    echo ""
    exit  ;;
    "q")  echo ""
    echo "오늘 하루도 화이팅! :)"
    echo ""
    exit   ;; 
    "") echo ""
    echo "작업 번호를 입력해주세요~~"
    echo ""
    exit
    ;;
     * )  echo ""
     echo "이거 말구요~!: $REPLY"     ;;
    esac
    sleep 1
done
