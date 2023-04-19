class CloudSqlProxy < Formula
  desc "The Cloud SQL Proxy for GoogleCloudPlatform"
  homepage "https://github.com/GoogleCloudPlatform/cloudsql-proxy"
  version "2.1.2"
  url "https://github.com/GoogleCloudPlatform/cloud-sql-proxy/archive/refs/tags/v#{version}.tar.gz"
  sha256 "375e577e993e72f8c35d43e2b0672862f3bb10c1ca49fcc7c1f98b9e42fb7261"
  head "https://github.com/GoogleCloudPlatform/cloud-sql-proxy.git"

  depends_on "go" => :build

  def install
    system "go", "build", "-o", bin/"cloud_sql_proxy", "."
  end

  service do
    run [opt_bin/"cloud_sql_proxy"]
    keep_alive true
        
    # Select all environment variables that start with CSQL_PROXY_
    csql_proxy_env_vars = ENV.select { |k, _| k.start_with?("CSQL_PROXY_") }
    environment_variables csql_proxy_env_vars
  end

  test do
    system "cloud_sql_proxy -version"
  end
end
