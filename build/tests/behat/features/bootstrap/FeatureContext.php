<?php

use Behat\Behat\Context\ContextInterface;
use Behat\Behat\Exception\PendingException;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;
use Behat\MinkExtension\Context\RawMinkContext;
use Behat\Testwork\Hook\Scope\BeforeSuiteScope;
use Behat\Testwork\Hook\Scope\AfterSuiteScope;

/**
 * Behat context class.
 */

class FeatureContext extends MinkContext
{

    /**
     * Initializes context. Every scenario gets it's own context object.
     *
     * @param array $parameters Suite parameters (set them up through behat.yml)
     */
    public function __construct(Array $parameters) {
        require_once (dirname(dirname(__DIR__))).DIRECTORY_SEPARATOR."config".DIRECTORY_SEPARATOR."QAWorksConfigFactory.php" ;
        $this->useContext('google', new \GoogleContext()) ;
    }

    public function fillField($field, $with) {
        sleep(3);
        $page = $this->getMainContext()->getSession()->getPage() ;
        $el = $page->find('css', '#'.$field) ;
        if (!$el) { throw new Exception('Unable to find field '.$field); }
        $el->setValue($with) ;
    }

    public function iAmOnTheHomePage() {
        $hp = getenv("");
        $session = $this->getMainContext()->getSession() ;
        $session->visit($hp);
        sleep(1);
    }

    public function assertPageContainsText($searchFor) {
        $page = $this->getMainContext()->getSession()->getPage() ;
        $text = $page->getText() ;
        if (strpos($text, $searchFor)==false) {  throw new Exception('Unable to find text '.$searchFor.' in '.$text); }
    }


    
}