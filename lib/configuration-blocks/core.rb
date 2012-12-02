# Author::    Paweł Wilk (mailto:pw@gnu.org)
# Copyright:: (c) 2012 by Paweł Wilk
# License::   This program is licensed under the terms of {file:LGPL-LICENSE GNU Lesser General Public License} or {file:COPYING Ruby License}.
#
# This file contains ConfigurationBlocks module.

require 'set'

# This module adds support for configuration blocks.
module ConfigurationBlocks

  # @private
  def self.included(base)
    base.extend(ClassMethods)
    base.singleton_class.extend(ClassMethods)
    super if defined?(super)
  end

  # Returns configuration block.
  # 
  # @param base [Object,Symbol] base object which delegators will point to (defaults to object on which
  #  this method has been called). If symbol is given, then it should contain the name of a method that
  #  will be called on current object.
  # @return [Object] result of evaluating the given block within context of configuration module
  def configuration_block(base = self, &block)
    self.class.configuration_block(base, &block)
  end

  # Returns configuration module that delegates methods pointing to the given +base+ object
  # and optionally evaluates the given block in the context of this module or in the current context.
  # 
  # If a block is given then it is evaluated in the context of the configuration module.
  # If a block with at least one argument is given then the context remains as it was
  # but the first argument is the module.
  # 
  # @example
  #   # using external access to configuration module:
  #   x.configuration_block do |c|
  #     c.some_setting  :a
  #     c.other_setting :b
  #   end
  #   
  #   # using internal access to configuration module:
  #   x.configuration_block do
  #     some_setting  :a
  #     other_setting :b
  #   end
  # 
  # @param base [Object,Symbol] base object which delegators will point to (defaults to object on which
  #  this method has been called). If symbol is given, then it should contain the name of a method that
  #  will be called on current object.
  # @return [Module,Object] configuration module if not block is given or a block takes no arguments. In case
  #  of one or more arguments in a block it also returns a module unless +break+ statement is used; in such case
  #  the value passed to +break+ is returned.
  def configuration_block(base = self, &block)
    @cb_conf_module ||= self.class.configuration_module(base)
    self.class.send(:configuration_block_core, @cb_conf_module, &block)
  end

  # This module contains methods that will extend the class.
  module ClassMethods

    # Returns configuration block.
    # 
    # @param base [Object,Symbol] base object which delegators will point to (defaults to object on which
    #  this method has been called). If symbol is given, then it should contain the name of a method that
    #  will be called on current object.
    # 
    # @return [Object] result of evaluating the given block within context of configuration module
    def configuration_block(base = self, &block)
      @cb_conf_module ||= configuration_module(base)
      configuration_block_core(@cb_conf_module, &block)
    end

    # Creates and returns anonymous module containing
    # delegators that point to methods from a class this module is included in
    # or the given +base+.
    # 
    # @param base [Object,Symbol] base object which delegators will point to (defaults to object on which
    #  this method has been called). If symbol is given, then it should contain the name of a method that
    #  will be called on current object.
    # 
    # @return [Module] anonymous module with proxy module methods delegating actions to +base+ object
    def configuration_module(base = self)
      Module.new.tap do |cm|
        delegators = get_configuration_methods
        base = send(base) if base.is_a?(Symbol)
        cm.extend Module.new {
          delegators.each do |method|
            module_eval do
              define_method(method) do |*args|
                base.send(method, *args)
              end
            end
          end
        }
      end
    end

    # Gets all method names known to configuration engine.
    # 
    # @param local_only [Boolean] optional flag that if set, causes only methods added
    #  by current class or module to be listed.
    # 
    # @return [Array<Symbol>] delegated method names
    def get_configuration_methods(local_only = false)
      all_delegators = singleton_class.send(:cf_block_delegators) + cf_block_delegators
      return all_delegators if local_only
      ancestors.each_with_object(all_delegators) do |ancestor, all|
        all.merge(ancestor.send(__method__, true)) if ancestor.respond_to?(__method__)
      end
    end

    # This DSL method is intended to be used in a class or module to indicate which methods
    # should be delegated.
    # 
    # @param methods [Array<Symbol,String>] list of method names
    # @return [nil]
    def configuration_block_delegate(*methods)
      methods.flatten.each { |m| cf_block_delegators.add(m.to_sym) }
      @cb_conf_module = nil if @cb_conf_module
      nil
    end
    alias_method :configuration_method,   :configuration_block_delegate
    alias_method :configuration_methods,  :configuration_block_delegate
    alias_method :settings_method,        :configuration_block_delegate

    private

    # Getter for +@cf_block_delegators+ internal variable.
    def cf_block_delegators
      @cf_block_delegators ||= Set.new
    end

    # Evaluates configuration block within a context of the given module.
    def configuration_block_core(conf_module, &block)
      return conf_module unless block_given?
      return conf_module.tap(&block) unless block.arity == 0
      conf_module.module_eval(&block)
      conf_module
    end

  end # module ClassMethods

end # module ConfigurationBlocks
