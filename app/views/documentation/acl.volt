<div class="body">

    <div class="section" id="access-control-lists-acl">
        <h1>Access Control Lists ACL<a class="headerlink" href="#access-control-lists-acl" title="Ссылка на этот заголовок">¶</a></h1>

        <p><tt class="xref doc docutils literal"><span class="pre">Phalcon\Acl</span></tt> provides an easy and lightweight management of ACLs as well as the permissions
            attached to them. <a class="reference external" href="http://en.wikipedia.org/wiki/Access_control_list">Access Control Lists</a> (ACL) allow an application to control access to its areas
            and the underlying
            objects from requests. You are encouraged to read more about the ACL methodology so as to be familiar with its concepts.</p>

        <p>In summary, ACLs have roles and resources. Resources are objects which abide by the permissions defined to them by
            the ACLs. Roles are objects that request access to resources and can be allowed or denied access by the ACL mechanism.</p>

        <div class="section" id="creating-an-acl">
            <h2>Creating an ACL<a class="headerlink" href="#creating-an-acl" title="Ссылка на этот заголовок">¶</a></h2>

            <p>This component is designed to initially work in memory. This provides ease of use and speed in accessing every aspect of the list. The <tt class="xref doc docutils literal"><span
                    class="pre">Phalcon\Acl</span></tt> constructor takes as its first parameter an adapter used to retriever the information related to the control list. An example using the memory
                adapter is below:</p>

            <div class="highlight-php">
                <div class="highlight"><pre><span class="cp">&lt;?php</span> <span class="nv">$acl</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">\Phalcon\Acl\Adapter\Memory</span><span
                        class="p">();</span>
</pre>
                </div>
            </div>
            <p>By default <tt class="xref doc docutils literal"><span class="pre">Phalcon\Acl</span></tt> allows access to action on resources that have not been yet defined. To increase the security
                level of the access list we can define a &#8220;deny&#8221; level as a default access level.</p>

            <div class="highlight-php">
                <div class="highlight"><pre><span class="cp">&lt;?php</span>

<span class="c1">// Default action is deny access</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">setDefaultAction</span><span class="p">(</span><span class="nx">Phalcon\Acl</span><span class="o">::</span><span class="na">DENY</span><span
                            class="p">);</span>
</pre>
                </div>
            </div>
        </div>
        <div class="section" id="adding-roles-to-the-acl">
            <h2>Adding Roles to the ACL<a class="headerlink" href="#adding-roles-to-the-acl" title="Ссылка на этот заголовок">¶</a></h2>

            <p>A role is an object that can or cannot access certain resources in the access list. As an example, we will define roles as groups of people in an organization. The <tt
                    class="xref doc docutils literal"><span class="pre">Phalcon\Acl\Role</span></tt> class is available to create roles in a more structured way. Let&#8217;s add some roles to our
                recently created list:</p>

            <div class="highlight-php">
                <div class="highlight"><pre><span class="cp">&lt;?php</span>

<span class="c1">// Create some roles</span>
<span class="nv">$roleAdmins</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">\Phalcon\Acl\Role</span><span class="p">(</span><span
                            class="s2">&quot;Administrators&quot;</span><span class="p">,</span> <span class="s2">&quot;Super-User role&quot;</span><span class="p">);</span>
<span class="nv">$roleGuests</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">\Phalcon\Acl\Role</span><span class="p">(</span><span class="s2">&quot;Guests&quot;</span><span
                            class="p">);</span>

<span class="c1">// Add &quot;Guests&quot; role to acl</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">addRole</span><span class="p">(</span><span class="nv">$roleGuests</span><span class="p">);</span>

<span class="c1">// Add &quot;Designers&quot; role to acl without a Phalcon\Acl\Role</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">addRole</span><span class="p">(</span><span class="s2">&quot;Designers&quot;</span><span class="p">);</span>
</pre>
                </div>
            </div>
            <p>As you can see, roles are defined directly without using an instance.</p>
        </div>
        <div class="section" id="adding-resources">
            <h2>Adding Resources<a class="headerlink" href="#adding-resources" title="Ссылка на этот заголовок">¶</a></h2>

            <p>Resources are objects where access is controlled. Normally in MVC applications resources refer to controllers. Although this is not mandatory, the <tt class="xref doc docutils literal"><span
                    class="pre">Phalcon\Acl\Resource</span></tt> class can be used in defining resources. It&#8217;s important to add related actions or operations to a resource so that the ACL can
                understand what it should to control.</p>

            <div class="highlight-php">
                <div class="highlight"><pre><span class="cp">&lt;?php</span>

<span class="c1">// Define the &quot;Customers&quot; resource</span>
<span class="nv">$customersResource</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">\Phalcon\Acl\Resource</span><span class="p">(</span><span class="s2">&quot;Customers&quot;</span><span
                            class="p">);</span>

<span class="c1">// Add &quot;customers&quot; resource with a couple of operations</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">addResource</span><span class="p">(</span><span class="nv">$customersResource</span><span class="p">,</span> <span class="s2">&quot;search&quot;</span><span
                            class="p">);</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">addResource</span><span class="p">(</span><span class="nv">$customersResource</span><span class="p">,</span> <span class="k">array</span><span
                            class="p">(</span><span class="s2">&quot;create&quot;</span><span class="p">,</span> <span class="s2">&quot;update&quot;</span><span class="p">));</span>
</pre>
                </div>
            </div>
        </div>
        <div class="section" id="defining-access-controls">
            <h2>Defining Access Controls<a class="headerlink" href="#defining-access-controls" title="Ссылка на этот заголовок">¶</a></h2>

            <p>Now we&#8217;ve roles and resources. It&#8217;s time to define the ACL i.e. which roles can access which resources. This part is very important especially taking in consideration your
                default access level &#8220;allow&#8221; or &#8220;deny&#8221;.</p>

            <div class="highlight-php">
                <div class="highlight"><pre><span class="cp">&lt;?php</span>

<span class="c1">// Set access level for roles into resources</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">allow</span><span class="p">(</span><span class="s2">&quot;Guests&quot;</span><span class="p">,</span> <span class="s2">&quot;Customers&quot;</span><span
                            class="p">,</span> <span class="s2">&quot;search&quot;</span><span class="p">);</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">allow</span><span class="p">(</span><span class="s2">&quot;Guests&quot;</span><span class="p">,</span> <span class="s2">&quot;Customers&quot;</span><span
                            class="p">,</span> <span class="s2">&quot;create&quot;</span><span class="p">);</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">deny</span><span class="p">(</span><span class="s2">&quot;Guests&quot;</span><span class="p">,</span> <span class="s2">&quot;Customers&quot;</span><span
                            class="p">,</span> <span class="s2">&quot;update&quot;</span><span class="p">);</span>
</pre>
                </div>
            </div>
            <p>The allow method designates that a particular role has granted access to access a particular resource. The deny method does the opposite.</p>
        </div>
        <div class="section" id="querying-an-acl">
            <h2>Querying an ACL<a class="headerlink" href="#querying-an-acl" title="Ссылка на этот заголовок">¶</a></h2>

            <p>Once the list has been completely defined. We can query it to check if a role has a given permission or not.</p>

            <div class="highlight-php">
                <div class="highlight"><pre><span class="cp">&lt;?php</span>

<span class="c1">// Check whether role has access to the operations</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">isAllowed</span><span class="p">(</span><span class="s2">&quot;Guests&quot;</span><span class="p">,</span> <span class="s2">&quot;Customers&quot;</span><span
                            class="p">,</span> <span class="s2">&quot;edit&quot;</span><span class="p">);</span>   <span class="c1">//Returns 0</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">isAllowed</span><span class="p">(</span><span class="s2">&quot;Guests&quot;</span><span class="p">,</span> <span class="s2">&quot;Customers&quot;</span><span
                            class="p">,</span> <span class="s2">&quot;search&quot;</span><span class="p">);</span> <span class="c1">//Returns 1</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">isAllowed</span><span class="p">(</span><span class="s2">&quot;Guests&quot;</span><span class="p">,</span> <span class="s2">&quot;Customers&quot;</span><span
                            class="p">,</span> <span class="s2">&quot;create&quot;</span><span class="p">);</span> <span class="c1">//Returns 1</span>
</pre>
                </div>
            </div>
        </div>
        <div class="section" id="roles-inheritance">
            <h2>Roles Inheritance<a class="headerlink" href="#roles-inheritance" title="Ссылка на этот заголовок">¶</a></h2>

            <p>You can build complex role structures using the inheritance that <tt class="xref doc docutils literal"><span class="pre">Phalcon\Acl\Role</span></tt> provides. Roles can inherit from
                other roles, thus allowing access to supersets or subsets of resources. To use role inheritance, you need to pass the inherited role as the second parameter of the function call, when
                adding that role in the list.</p>

            <div class="highlight-php">
                <div class="highlight"><pre><span class="cp">&lt;?php</span>

<span class="c1">// Create some roles</span>
<span class="nv">$roleAdmins</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">\Phalcon\Acl\Role</span><span class="p">(</span><span
                            class="s2">&quot;Administrators&quot;</span><span class="p">,</span> <span class="s2">&quot;Super-User role&quot;</span><span class="p">);</span>
<span class="nv">$roleGuests</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">\Phalcon\Acl\Role</span><span class="p">(</span><span class="s2">&quot;Guests&quot;</span><span
                            class="p">);</span>

<span class="c1">// Add &quot;Guests&quot; role to acl</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">addRole</span><span class="p">(</span><span class="nv">$roleGuests</span><span class="p">);</span>

<span class="c1">// Add &quot;Administrators&quot; role inheriting from &quot;Guests&quot; its accesses</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">addRole</span><span class="p">(</span><span class="nv">$roleAdmins</span><span class="p">,</span> <span
                            class="nv">$roleGuests</span><span class="p">);</span>
</pre>
                </div>
            </div>
        </div>
        <div class="section" id="serializing-acl-lists">
            <h2>Serializing ACL lists<a class="headerlink" href="#serializing-acl-lists" title="Ссылка на этот заголовок">¶</a></h2>

            <p>To improve performance <tt class="xref doc docutils literal"><span class="pre">Phalcon\Acl</span></tt> instances can be serialized and stored in APC, session, text files or a database
                table
                so that they can be loaded at will without having to redefine the whole list. You can do that as follows:</p>

            <div class="highlight-php">
                <div class="highlight"><pre><span class="cp">&lt;?php</span>

<span class="c1">//Check whether acl data already exist</span>
<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="nb">file_exists</span><span class="p">(</span><span class="s2">&quot;app/security/acl.data&quot;</span><span
                            class="p">))</span> <span class="p">{</span>

    <span class="nv">$acl</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">\Phalcon\Acl\Adapter\Memory</span><span class="p">();</span>

    <span class="c1">//... Define roles, resources, access, etc</span>

    <span class="c1">// Store serialized list into plain file</span>
    <span class="nb">file_put_contents</span><span class="p">(</span><span class="s2">&quot;app/security/acl.data&quot;</span><span class="p">,</span> <span class="nb">serialize</span><span class="p">(</span><span
                            class="nv">$acl</span><span class="p">));</span>

<span class="p">}</span> <span class="k">else</span> <span class="p">{</span>

     <span class="c1">//Restore acl object from serialized file</span>
     <span class="nv">$acl</span> <span class="o">=</span> <span class="nb">unserialize</span><span class="p">(</span><span class="nb">file_get_contents</span><span class="p">(</span><span class="s2">&quot;app/security/acl.data&quot;</span><span
                            class="p">));</span>
<span class="p">}</span>

<span class="c1">// Use acl list as needed</span>
<span class="k">if</span> <span class="p">(</span><span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">isAllowed</span><span class="p">(</span><span
                            class="s2">&quot;Guests&quot;</span><span class="p">,</span> <span class="s2">&quot;Customers&quot;</span><span class="p">,</span> <span
                            class="s2">&quot;edit&quot;</span><span class="p">))</span> <span class="p">{</span>
    <span class="k">echo</span> <span class="s2">&quot;Access granted!&quot;</span><span class="p">;</span>
<span class="p">}</span> <span class="k">else</span> <span class="p">{</span>
    <span class="k">echo</span> <span class="s2">&quot;Access denied :(&quot;</span><span class="p">;</span>
<span class="p">}</span>
</pre>
                </div>
            </div>
        </div>
        <div class="section" id="acl-events">
            <h2>Acl Events<a class="headerlink" href="#acl-events" title="Ссылка на этот заголовок">¶</a></h2>

            <p><tt class="xref doc docutils literal"><span class="pre">Phalcon\Acl</span></tt> is able to send events to a <a class="reference internal" href="events.html"><em>EventsManager</em></a>
                if it&#8217;s present. Events
                are triggered using the type &#8220;acl&#8221;. Some events when returning boolean false could stop the active operation. The following events are supported:</p>
            <table border="1" class="docutils">
                <colgroup>
                    <col width="21%"/>
                    <col width="58%"/>
                    <col width="20%"/>
                </colgroup>
                <thead valign="bottom">
                <tr class="row-odd">
                    <th class="head">Event Name</th>
                    <th class="head">Triggered</th>
                    <th class="head">Can stop operation?</th>
                </tr>
                </thead>
                <tbody valign="top">
                <tr class="row-even">
                    <td>beforeCheckAccess</td>
                    <td>Triggered before checking if a role/resource has access</td>
                    <td>Yes</td>
                </tr>
                <tr class="row-odd">
                    <td>afterCheckAccess</td>
                    <td>Triggered after checking if a role/resource has access</td>
                    <td>No</td>
                </tr>
                </tbody>
            </table>
            <p>The following example demonstrates how to attach listeners to this component:</p>

            <div class="highlight-php">
                <div class="highlight"><pre><span class="cp">&lt;?php</span>

<span class="c1">//Create an event manager</span>
<span class="nv">$eventsManager</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">Phalcon\Events\Manager</span><span class="p">();</span>

<span class="c1">//Attach a listener for type &quot;acl&quot;</span>
<span class="nv">$eventsManager</span><span class="o">-&gt;</span><span class="na">attach</span><span class="p">(</span><span class="s2">&quot;acl&quot;</span><span class="p">,</span> <span class="k">function</span><span
                            class="p">(</span><span class="nv">$event</span><span class="p">,</span> <span class="nv">$acl</span><span class="p">)</span> <span class="p">{</span>
    <span class="k">if</span> <span class="p">(</span><span class="nv">$event</span><span class="o">-&gt;</span><span class="na">getType</span><span class="p">()</span> <span class="o">==</span> <span
                            class="s1">&#39;beforeCheckAccess&#39;</span><span class="p">)</span> <span class="p">{</span>
         <span class="k">echo</span>   <span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">getActiveRole</span><span class="p">(),</span>
                <span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">getActiveResource</span><span class="p">(),</span>
                <span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">getActiveAccess</span><span class="p">();</span>
    <span class="p">}</span>
<span class="p">});</span>

<span class="nv">$acl</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">\Phalcon\Acl\Adapter\Memory</span><span class="p">();</span>

<span class="c1">//Setup the $acl</span>
<span class="c1">//...</span>

<span class="c1">//Bind the eventsManager to the acl component</span>
<span class="nv">$acl</span><span class="o">-&gt;</span><span class="na">setEventsManager</span><span class="p">(</span><span class="nv">$eventManagers</span><span class="p">);</span>
</pre>
                </div>
            </div>
        </div>
        <div class="section" id="implementing-your-own-adapters">
            <h2>Implementing your own adapters<a class="headerlink" href="#implementing-your-own-adapters" title="Ссылка на этот заголовок">¶</a></h2>

            <p>The <tt class="xref doc docutils literal"><span class="pre">Phalcon\Acl\AdapterInterface</span></tt> interface must be implemented in order
                to create your own ACL adapters or extend the existing ones.</p>
        </div>
    </div>


</div>
