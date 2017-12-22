while true
do
  echo "exec curator"
  /usr/bin/curator  --config /curator/config.yml /curator/actions.yml
  sleep 60;
done