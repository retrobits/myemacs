(defvar slime-path)
(defvar encoding-fmt)
(defvar slime-port)

(sys:with-command-line-arguments (("p" :short port :required)
				  ("ef" :long ef :required)
				  ("sl" :long sl :required))
  (restvar)
  (setq slime-path sl)
  (setq encoding-fmt ef)
  (setq slime-port port))

(print slime-path)
(print encoding-fmt)
(print slime-port)

(load (excl.shell:concat slime-path "swank-loader.lisp"))
(swank::create-server :port (parse-integer slime-port :junk-allowed nil)
		        :style :spawn
	                :dont-close t
			:coding-system (or encoding-fmt "latin-1"))

#| a C# routine to manage the allegro windows, todo: convert to lisp

        public void Cleanup()
        {
            int waitMs = 200;
            int consoleHwnd = 0;
            _stop = new ManualResetEvent(false);
            _stop.WaitOne(waitMs, false);

            int hwnd = Win32.FindWindow(null, "cleaner.exe");
            if (hwnd != 0) Win32.ShowWindow(hwnd, 0); 

            while (!_stop.WaitOne(waitMs, false))
            {
                hwnd = Win32.FindWindow("Allegro CL Free Express", "Allegro CL Free Express");
                if (hwnd != 0) Win32.SendMessage(hwnd, Win32.WM_KEYDOWN, 0x1b, 0x00010001); // send Esc

                hwnd = Win32.FindWindow("WebclosFrame", "Allegro Common Lisp Console - [mlisp.dxl]");
                if (hwnd != 0 && consoleHwnd != hwnd) consoleHwnd = hwnd; Win32.ShowWindow(hwnd, 0);
            }
        }
|#