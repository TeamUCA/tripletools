<?php
/* admin finder UCA 
coded by Zak UCA
 */
echo "   comand admin Finder From U.C.A";
echo "===========>";


$wl = file_get_contents("wordlist.txt");

class AdFinder {
  private $WL;
  
  public function __construct(string $wl) {
    $this->WL = $wl;
    self::Start();
  }
  
  //Start Finder
  public function Start() {
    $site = getopt("u:")["u"];
    if (isset($site) && !empty($site) && preg_match("/\./", $site)):
      $os = ucfirst(substr(PHP_OS, 0, 3));
      if ($os === "Win"):
        system("cls && color 0a");
        $P = null;
        $M = null;
        $H = null;
        $B = null;
      else:
        system("clear");
        $P = "\e[1;37m";
        $M = "\e[1;31m";
        $H = "\e[1;32m";
        $B = "\e[1;34m";
      endif;
      if (!preg_match("/^https?:\/\//", $site)):
        $site = "http://{$site}";
      endif;
      if (!preg_match("/\/$/", $site)):
        $site .= "/";
      endif;
      
      $WL = explode(PHP_EOL, $this->WL);
      $WC = count($WL);
      echo "{$B}Total Word List: {$P}{$WC}", PHP_EOL;
      for ($i = 0; $i < $WC; $i++):
        $rest = "{$site}{$WL[$i]}";
        $ch = curl_init($rest);
        curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_FOLLOWLOCATION => true,
        CURLOPT_SSL_VERIFYPEER => false,
        CURLOPT_SSL_VERIFYHOST => false
        ]);
        curl_exec($ch);
        $http = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);
        if ($http === 200):
          $result .= "{$rest}" . PHP_EOL;
          echo "{$H}[{$H} Ada ga{$H}] >{$H} {$P}{$rest}", PHP_EOL;
          echo "{$H}[{$P}Tekan {$B}Enter{$P} untuk Lanjut Cari{$H}]", PHP_EOL, "{$H}[{$P}Ketik {$B}\"q\"{$P} dan Tekan {$B}Enter{$P} untuk Keluar{$H}]", PHP_EOL, "{$B}Input: {$P}";
          $next = trim(strtolower(fgets(STDIN)));
          ($next == "q") ? die("Bye~" . PHP_EOL) : null;
        else:
          echo "{$M}[{$M}Ga ada{$M}] >{$M} {$P}{$rest}", PHP_EOL;
        endif;
      endfor;
      if (!empty($result)):
        echo PHP_EOL, "{$H}Total Ketemu:", PHP_EOL, "{$P}{$result}{$H}--{$P}", PHP_EOL;
        if (count(explode(PHP_EOL, trim($result))) >= 5):
          Rest:
          echo "{$P}Result ingin disimpan sebagai file Result.txt?", PHP_EOL, "{$B}Input (y/n): {$P}";
          $mkf = trim(strtolower(fgets(STDIN)));
          if (isset($mkf) && !empty($mkf) && $mkf === "y"):
            $z = fopen(basename(__DIR__ . "/result.txt"), "a+");
            if (fwrite($z, $result)):
              echo "Result {$H}Berhasil {$P}dibuat!", PHP_EOL;
            else:
              echo "Result {$M}Gagal {$P}Dibuat~", PHP_EOL;
            endif;
            fclose($z);
          elseif (isset($mkf) && !empty($mkf) && $mkf === "n"):
            die("Thanks" . PHP_EOL);
          else:
            goto Rest;
          endif;
        endif;
      else:
        echo PHP_EOL, "{$M}Tidak ada yang Ketemu!{$P}", PHP_EOL;
      endif;
    else:
       die(" Masukkan :  " . basename(__FILE__) . " -u site.com" . PHP_EOL);
    endif;
  }
}
new AdFinder($wl);