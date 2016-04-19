<?php


use Behat\Behat\Context\BehatContext;
use Behat\Behat\Context\ContextInterface;
use Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\MinkExtension\Context\MinkContext;

/**
 * Behat context class.
 */

class GoogleContext extends BehatContext implements ContextInterface
{

    /**
     * @Then /^I should see the google logo$/
     */
    public function iShouldSeeTheGoogleLogo() {
        $page = $this->getMainContext()->getSession()->getPage() ;
        $logo = $page->find('css', 'html body div#main span#body div#hplogo');
        if (!$logo) { throw new Exception('No Google Logo there'); }
    }

    /**
     * @Then /^I should see the google menu$/
     */
    public function iShouldSeeTheGoogleMenu() {
        $page = $this->getMainContext()->getSession()->getPage() ;
        $menu = $page->find('css', 'html body div#viewport div#searchform div#gb');
        if (!$menu) { throw new Exception('No Google Menu there'); }
    }


    /**
     * @Then /^I am the boss$/
     */
    public function iAmTheBoss() {
        echo "who else\n" ;
    }


}