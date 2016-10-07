import pexpect
import threading

def worker(start):
  """thread worker function"""
  start = start * 100
  end = start + 100
  print "Worker %d %d" % (start, end)
  for i in xrange(start, end):
    p = pexpect.spawn("./access")
    p.expect("Please enter your name:")
    p.sendline("david")
    p.expect("david, please enter your PIN:")
    pin = (str(i) + "8").zfill(4)

    p.sendline(pin)
    try:
      p.expect("Success.")
    except Exception as e:
      pass
    else:
      print pin
      exit(0)

    p.close()

threads = []
for i in range(9):
  t = threading.Thread(target=worker, args=(i,))
  threads.append(t)
  print "Starting thread %d" % i
  t.start()