# vitis -s setup.py hello1
# vitis --workspace ./workspace/

import vitis
import os
import sys

app_name = "hls_tpg"
print("app_name = ", app_name)

#hw_xsa = "../../implement/results/top.xsa"
os.system('rm -rf workspace')

client = vitis.create_client()
client.set_workspace(path="./workspace")

comp = client.create_hls_component(name=app_name, cfg_file=["./config.cfg"], template="empty_hls_component")
comp = client.get_component(name=app_name)

comp.run(operation="SYNTHESIS")
comp.run(operation="PACKAGE")

vitis.dispose()




