#!/usr/bin/env ruby

require_relative 'contact_application'

contact_app = ContactApplication.new(ARGV)
contact_app.run
