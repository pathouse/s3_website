Feature: improve response times of your S3 website website

  As a blogger
  I want to benefit from HTTP performance optimisations
  So that my readers would not have to wait long for my website to load

  @new-files
  Scenario: Set Cache-Control: max-age for all uploaded files
    When my S3 website is in "features/support/test_site_dirs/site.with.maxage.com"
    And I call the push command
    Then the output should contain
      """
      Upload css/styles.css [max-age=120]: Success!
      """
    And the output should contain
      """
      Upload index.html [max-age=120]: Success!
      """

  @new-files
  Scenario: Set Cache-Control: max-age for CSS files only
    When my S3 website is in "features/support/test_site_dirs/site.with.css-maxage.com"
    And I call the push command
    Then the output should contain
      """
      Upload css/styles.css [max-age=100]: Success!
      """
    And the output should contain
      """
      Upload index.html [max-age=0]: Success!
      """

  @new-files
  Scenario: Set Content-Encoding: gzip HTTP header for HTML files
    When my S3 website is in "features/support/test_site_dirs/site.with.gzipped-html.com"
    And I call the push command
    Then the output should contain
      """
      Upload css/styles.css: Success!
      """
    And the output should contain
      """
      Upload index.html [gzipped]: Success!
      """

  @new-files
  Scenario: Set both the Content-Encoding: gzip and Cache-Control: max-age headers
    When my S3 website is in "features/support/test_site_dirs/site.with.gzipped-and-max-aged-content.com"
    And I call the push command
    Then the output should contain
      """
      Upload css/styles.css [gzipped] [max-age=300]: Success!
      """
    And the output should contain
      """
      Upload index.html [gzipped] [max-age=300]: Success!
      """
