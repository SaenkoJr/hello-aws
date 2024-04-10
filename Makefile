start:
	rm -rf tmp/pids/server.pid
	bin/rails s -b '0.0.0.0' -p 5555
