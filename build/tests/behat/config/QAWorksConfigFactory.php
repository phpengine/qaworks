<?php

class QAWorksConfigFactory {

    public $config ;
    protected $environment ;
    
    public function __construct() {
        $this->config = new \StdClass() ;
        $this->setValues() ;
    }
    
    protected function setValues() {
        $this->config->default_admin_user = "some-admin" ;
    }

    public function getValue($valName) {
        if (isset($this->config->$valName)) { return $this->config->$valName ; }
        return null ;
    }

}