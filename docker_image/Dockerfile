FROM honeynet/droidbox
ADD run_demo.sh /build/
ADD run_apk.sh /build/
ADD droidbox_new.py /opt/DroidBox_4.1.1/scripts/
ADD images_new /opt/DroidBox_4.1.1/images_new
ENTRYPOINT ["/build/run_demo.sh"]
