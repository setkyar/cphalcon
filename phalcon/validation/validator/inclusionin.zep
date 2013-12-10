
/*
 +------------------------------------------------------------------------+
 | Phalcon Framework                                                      |
 +------------------------------------------------------------------------+
 | Copyright (c) 2011-2013 Phalcon Team (http://www.phalconphp.com)       |
 +------------------------------------------------------------------------+
 | This source file is subject to the New BSD License that is bundled     |
 | with this package in the file docs/LICENSE.txt.                        |
 |                                                                        |
 | If you did not receive a copy of the license and are unable to         |
 | obtain it through the world-wide-web, please send an email             |
 | to license@phalconphp.com so we can send you a copy immediately.       |
 +------------------------------------------------------------------------+
 | Authors: Andres Gutierrez <andres@phalconphp.com>                      |
 |          Eduar Carvajal <eduar@phalconphp.com>                         |
 +------------------------------------------------------------------------+
 */

namespace Phalcon\Validation\Validator;

/**
 * Phalcon\Validation\Validator\InclusionIn
 *
 * Check if a value is included into a list of values
 *
 *<code>
 *use Phalcon\Validation\Validator\InclusionIn;
 *
 *$validator->add('status', new InclusionIn(array(
 *   'message' => 'The status must be A or B',
 *   'domain' => array('A', 'B')
 *)));
 *</code>
 */
class InclusionIn extends Phalcon\Validation\Validator implements Phalcon\Validation\ValidatorInterface
{

	/**
	 * Executes the validation
	 *
	 * @param Phalcon\Validation validator
	 * @param string attribute
	 * @return boolean
	 */
	public function validate(<Phalcon\Validation> validator, attribute) -> boolean
	{
		var value, domain, message;

		let value = validator->getValue(attribute);

		/**
		 * A domain is an array with a list of valid values
		 */
		let domain = this->getOption("domain");
		if typeof domain != "array" {
			throw new Phalcon\Validation\Exception("Option 'domain' must be an array");
		}

		/**
		 * Check if the value is contained by the array
		 */
		if !in_array(value, domain) {

			let message = this->getOption("message");
			if empty message {
				let message = "Value of field '" . attribute . "' must be part of list: " . join(", ", domain);
			}

			validator->appendMessage(new Phalcon\Validation\Message(message, attribute, "InclusionIn"));
			return false;
		}

		return true;
	}

}