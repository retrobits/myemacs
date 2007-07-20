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

