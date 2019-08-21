module AdaWetter
  VERSION = "0.1.0.4"
  HUM_VER = '0.1a0.4'
  
  PRERELEASE = false unless HUM_VER.include? 'a' or HUM_VER.include? 'rc'
  
  if HUM_VER.include? 'a'
    PRERELEASE = true
    PR_TYPE = 'alpha'
  end
  
  if HUM_VER.include? 'rc'
    PRERELEASE = true
    PR_TYPE = 'release candidate'
  end

end
