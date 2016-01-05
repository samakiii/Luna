<?php

include 'config.php';

class MySQL {

        public function __construct($strDBHost, $strDBUser, $strDBPass, $strDBName) {
                  $resCon = mysqli_connect($strDBHost, $strDBUser, $strDBPass, $strDBName);
                  $this->connection = $resCon;
                  return $resCon;
        }

        public function perfQuery($strQuery) {
                 $resQuery = mysqli_query($this->connection, $strQuery);
                 return $resQuery;
        }

       public function perfFetchArray($strQuery) {
                $resQuery = $this->perfQuery($strQuery);
                $arrResults = mysqli_fetch_array($resQuery);
                return $arrResults[0];
       }

       public function perfFetchAssoc($strQuery) {
                $resQuery = $this->perfQuery($strQuery);
                $arrResults = mysqli_fetch_assoc($resQuery);
                return $arrResults;
       }

       public function perfEscape($resString) {
                return mysqli_real_escape_string($this->connection, $resString);
       }

       public function perfRowCount($strQuery) {
                $resQuery = $this->perfQuery($strQuery);
                $intCount = mysqli_num_rows($resQuery);
                return $intCount;
       }

      public function closeMySQL() {
               mysqli_close($this->connection);
      }

}

$mysql = new MySQL($strDBHost, $strDBUser, $strDBPass, $strDBName);

?>
