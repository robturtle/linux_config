# Database
BKUP_PATH=/home/jeremy/.backup
test -e ${BKUP_PATH} || mkdir ${BKUP_PATH}
sudo /usr/bin/mysqldump -u redmine -p615324 redmine | gzip > ${BKUP_PATH}/redmine_$(date +%y_%m_%d).gz

# Attachments
ATCH_PATH=/usr/share/redmine/files
sudo rsync -a ${ATCH_PATH} ${BKUP_PATH}/redmine_files
